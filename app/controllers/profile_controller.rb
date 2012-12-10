class ProfileController < ApplicationController

  before_filter :authenticate_user!

  def index
    @user = current_user
    @task_reports = current_user.task_reports
    @projects = current_user.projects
  end

  def edit
    @user = current_user

    #if request.post?
    #  if (@updated = @user.update_attributes params[:user])
    #    @user.update_mailchimp
    #  else
    #    logger.info "\n Errors while updating user are #{@user.errors.inspect}"
    #  end
    #end
  end
end
