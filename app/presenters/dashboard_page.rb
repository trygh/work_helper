class DashboardPage

  attr_reader :user_stats, :user_weekly_stats, :user_monthly_stats
  attr_reader :project_stats, :project_weekly_stats, :project_monthly_stats

  def initialize(user)
    @user = user
    @project_ids = user.owned_project_ids.presence || [0] # empty project ids for users that do not have projects
    @var_interval = {'' => 'day', '_weekly' => 'week', '_monthly' => 'month'}

    @var_interval.each do |var_part, suffix|
      instance_variable_set("@user#{var_part}_stats", tasks_sum(Time.now.send("beginning_of_#{suffix}")))
    end

    load_users
    fill_users

    @var_interval.each do |var_part, suffix|
      instance_variable_set("@project#{var_part}_stats", tasks_sum_by_project(Time.now.send("beginning_of_#{suffix}")))
    end

    load_projects
    fill_projects
  end


  def fill_users
    @var_interval.keys.each do |var_part|
      var_name = "@user#{var_part}_stats"
      stats = instance_variable_get(var_name)

      result = {}
      stats.each do |user_id, value|
        result[@users[user_id]] = value
      end

      instance_variable_set var_name, result
    end
  end

  def fill_projects
    @var_interval.keys.each do |var_part|
      var_name = "@project#{var_part}_stats"
      stats = instance_variable_get(var_name)

      result = {}
      stats.each do |project_id, value|
        result[@projects[project_id]] = value
      end

      instance_variable_set var_name, result
    end
  end
  
  def load_projects
    project_ids = @var_interval.keys.map {|var_part| instance_variable_get("@project#{var_part}_stats").keys}.flatten.uniq
    @projects = Project.find(project_ids).index_by { |project| project.id }
  end

  def load_users
    user_ids = @var_interval.keys.map {|var_part| instance_variable_get("@user#{var_part}_stats").keys}.flatten.uniq
    @users = User.find(user_ids).index_by { |user| user.id }
  end

  def tasks_sum(started_at, ended_at = Time.now)
    TaskReport.where('reported_for between ? and ?', started_at, ended_at).where(project_id: @project_ids).
        group(:user_id).order('1 desc').sum(:minutes)
  end

  def tasks_sum_by_project(started_at, ended_at = Time.now)
    TaskReport.where('reported_for between ? and ?', started_at, ended_at).where(project_id: @project_ids).
        group(:project_id).order('1 desc').sum(:minutes)
  end
end
