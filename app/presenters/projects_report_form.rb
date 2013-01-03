class ProjectsReportForm
  # params
  # y - year
  # m = month
  # p - array with project IDs
  def initialize(user, params = {})
    @user = user
    @params = params

    begin
      @start_date = Date.new(params[:y].to_i, params[:m].to_i, 1)
    rescue ArgumentError
    end

    selected_ids = [params[:p]].flatten.compact.collect(&:to_i)

    if selected_ids.present?
      # exclude not owned projects
      selected_ids = selected_ids - (selected_ids - all_project_ids)
      @project_ids = selected_ids.presence
    end
  end

  def start_date
    @start_date ||= Date.today.beginning_of_month
  end

  def selected_project_ids
    @project_ids ||= all_project_ids
  end

  def all_project_ids
    @all_project_ids ||= all_projects.collect(&:id)
  end

  def all_projects
    @all_projects ||= @user.owned_projects.order :name
  end
end
