class ProjectsController < ApplicationController

  before_filter :authenticate_user!

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.projects.where(participants: { role_id: Participant::Role::OWNER}).order('created_at desc')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @reports = TaskReport.where(project_id: @project.id)
    @hours, @minutes = @reports.sum(:minutes).divmod(60)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  def add_participant
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

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(params[:project])

    respond_to do |format|
      if @project.save
        @project.create_owner(current_user)
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end
end
