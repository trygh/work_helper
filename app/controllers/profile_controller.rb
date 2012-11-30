class ProfileController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @task_reports = current_user.task_reports
  end

  def edit
  end
end
