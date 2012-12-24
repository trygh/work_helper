class ProjectsReport
	# project_ids is an array of project IDs
  # start_date is a date from which we will make our calculations
  def initialize(project_ids, start_date)
    @project_ids = project_ids
    @start_date = start_date.to_date
    @end_date = @start_date.end_of_month
	end

  # Returns a hash with project ID as key and task reports array as value
  def reports
    @reports ||= TaskReport.where('reported_for between ? and ?', @start_date, @end_date).
          where(project_id: @project_ids).order('reported_for, user_id').group_by {|report| report.project_id}
  end

  # Returns a hash with key as string that is project ID and value is an array with 4 elements
  # {1 => [[user_name, hourly_rate, total_hours, amount], ['Sergiu', 10, 156, 1560]]}
  def projects_summary
    results = {}

    reports.keys.each do |project_id|
      results[project_id] = project_summary(project_id)
    end

    results
  end

  # Returns an array with arrays
  # [[user_name, hourly_rate, total_hours, amount], ['Sergiu', 10, 156, 1560]]
  def project_summary(project_id)
    project_reports = reports[project_id]
    results = []

    if project_reports
      user_reports = project_reports.group_by{|report| report.user_id }
      user_reports.each do |user_id, reports|
        user = users[user_id]
        user_hours = (reports.map{|report| report.minutes}.sum/60.0).round(2)
        rate = user.dev_profile.try(:ext_hourly_rate)
        results << [user.name, user_hours, rate, (rate*user_hours).round(2) ]
      end
    end

    results
  end

  def project_name(project_id)
    projects[project_id].try :name
  end

  def project_amount(project_id)
    projects_summary[project_id].map {|stats| stats[3]}.sum
  end

  def total_amount
    total = 0

    reports.keys.each do |project_id|
      total += project_amount(project_id)
    end

    total
  end

  # Returns a hash, key is user ID and value is user object
  def users
    @users ||= begin
      user_ids = reports.values.flatten.map{|report| report.user_id}.uniq
      user_ids.present? ? User.find(user_ids).index_by{|user| user.id} : {}
    end
  end

  def projects
    @projects ||= Project.find(@project_ids).index_by{|project| project.id}

  end
end
