class CompaniesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @companies = Company.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def my_company
    @company = Company.where(user_id: current_user).first
    @your_workers = Worker.where('buyer_id & seller_id = ?', @company)
  end

  def assign_worker
    @seller = Company.where('id = ?', params[:worker][:seller_id]).first
    @buyer = Company.where('id = ?', params[:worker][:buyer_id]).first
    worker_owner = Worker.where(seller_id: @seller, buyer_id: @seller)

    if worker_owner.present? || @company.nil?
      create_worker
    else
      flash[:error] = "You are not owner for this user"
    end
    redirect_to my_company_path
  end

  def create_worker
    worker = Worker.new(user_id: params[:worker][:user_id], seller_id: params[:seller_id],
                        buyer_id: params[:worker][:buyer_id], hourly_rate: params[:worker][:hourly_rate])

    if worker.save
      flash[:notice] = "Invitation successfully sent"
    else
      flash[:notice] = "Something went wrong"
    end
  end

  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
    @company = Company.find(params[:id])
  end

  def create
    @company = Company.new(params[:company])
    @company.user_id = current_user.id

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
