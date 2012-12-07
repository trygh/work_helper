class ParticipantsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @participant = Participant.new
  end

  def create
    @user = User.where(email: params[:add_participant][:email]).first
    @project = Project.find(params[:project_id])
    if @user.present?
      @participant = Participant.where(user_id: @user.id, project_id: @project.id, role_id: params[:add_participant][:role_id])
      if @participant.present?
        redirect_to project_path(@project), notice: 'User allready exists.'
      else
        @participant = Participant.create user_id: @user.id, project_id: @project.id, role_id: params[:add_participant][:role_id]
        redirect_to project_path(@project), notice: 'User added to project.'
      end
    else
      redirect_to project_path(@project), notice: 'There is no user with this email.'
    end
  end
end
