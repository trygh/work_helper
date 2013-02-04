class TaskReportFilterPage

  attr_reader :task_reports, :project_filter, :user_filter, :start, :end

  def initialize(user, params)
    @user = user

    @user_id = params[:user_id].presence
    @project_id = params[:project_id].presence.to_i
    @project_ids = @user.owned_project_ids

    result = if @project_ids.include? @project_id
               @project_filter = true
               TaskReport.where(project_id: @project_id)
             else
               TaskReport.where(project_id: @project_ids)
             end

    if @user_id
      @user_filter = true
      result = result.where(:user_id => @user_id)
    end

    if params[:y].present? && params[:m].present?
      begin
        @start = Date.new(params[:y].to_i, params[:m].to_i, 1)
      rescue ArgumentError
        @start = Time.now.beginning_of_month
      end

      @end = @start.end_of_month
    else
      @end = Time.now
      @interval_filter = params[:interval]

      case params[:interval]
        when 'week'
          @start = Time.now.beginning_of_week
        when 'month'
          @start = Time.now.beginning_of_month
        else
          @start = Time.now.beginning_of_day
      end
    end

    result = result.where('reported_for between ? and ?', @start, @end)

    @task_reports = result.order('reported_for desc')
  end

  def project
    Project.find @project_id
  end

  def user
    User.find @user_id
  end

  def filters
    h = {}

    h[:user_id] = @user_id if @user_filter
    h[:project_id] = @project_id if @project_filter

    if @interval_filter
      h[:interval] = @interval_filter
    else
      h[:m] = @start.month
      h[:y] = @start.year
    end

    h
  end

  def prev_month
    @prev_month ||= @start.advance(:months => -1)
  end

  def total_minutes
    @task_reports.inject(0) {|total, task| total += task.minutes}
  end
end
