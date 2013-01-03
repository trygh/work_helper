class Projects::ParticipantsController < ApplicationController

  before_filter :authenticate_user!

  def create
    @worker = Worker.find(params[:participant][:worker_id])
    @user = User.where(id: @worker.user_id).first
    #FIXME only owners should be able to add participants
    @project = Project.find(params[:project_id])
    @company = @project.company

    if @user.present?
      @participant = Participant.where(user_id: @user.id, project_id: @project.id, worker_id: @worker.id)

      if @participant.present?
        @participant.update_all(role_id: params[:participant][:role_id])
        redirect_to company_project_path(@company, @project), notice: 'User updated.'
      else
        @participant = Participant.create user_id: @user.id, project_id: @project.id,
                                          role_id: params[:participant][:role_id], worker_id: @worker.id
        redirect_to company_project_path(@company, @project), notice: 'User added to project.'
      end
    else
      redirect_to company_project_path(@company, @project), error: 'There is no user with this email.'
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Participant has been removed from your project' }
      format.json { head :no_content }
    end
  end
end
