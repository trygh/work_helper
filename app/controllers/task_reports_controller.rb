class TaskReportsController < ApplicationController

  before_filter :authenticate_user!

  # GET /tasks
  # GET /tasks.json
  def index
    @task_reports = current_user.task_reports.order('reported_for desc')
    mm = @task_reports.sum(:minutes)
    @hh, @mm = mm.divmod(60)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @task_reports }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task_report = current_user.task_reports.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task_report }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task_report = TaskReport.new(reported_for: Date.today)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task_report }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task_report = current_user.task_reports.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task_report = current_user.task_reports.build(params[:task_report])

    respond_to do |format|
      if @task_report.save
        format.html { redirect_to task_reports_path, notice: 'Task was successfully created.' }
        format.json { render json: @task_report, status: :created, location: @task_report }
      else
        format.html { render action: "new" }
        format.json { render json: @task_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task_report = current_user.task_reports.find(params[:id])

    respond_to do |format|
      if @task_report.update_attributes(params[:task_report])
        format.html { redirect_to task_reports_path, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task_report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task_report = current_user.tasks.find(params[:id])
    @task_report.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end
end
