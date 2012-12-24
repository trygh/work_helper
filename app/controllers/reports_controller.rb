class ReportsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def projects_summary
    project_ids = current_user.owned_project_ids

    if project_ids.blank?
      redirect_to reports_path, notice: "you do not have any owned projects"
      return
    end

    @report = ProjectsReport.new(project_ids, Date.today.beginning_of_month)
  end

end
