class Projects::ParticipantsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @user = User.where(email: params[:participant][:email]).first
    #FIXME only owners should be able to add participants
    @project = Project.find(params[:project_id])

    if @user.present?
      @participant = Participant.where(user_id: @user.id, project_id: @project.id, role_id: params[:participant][:role_id])

      if @participant.present?
        redirect_to company_project_path(@company, @project), alert: 'User allready exists.'
      else
        @participant = Participant.create user_id: @user.id, project_id: @project.id, role_id: params[:participant][:role_id]
        redirect_to company_project_path(@company, @project), notice: 'User added to project.'
      end
    else
      redirect_to company_project_path(@company, @project), error: 'There is no user with this email.'
    end
  end
end
