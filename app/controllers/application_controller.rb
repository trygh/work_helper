class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_company
    @company = Company.where(id: params[:company_id] || params[:id]).first

    if @company.nil?
      flash[:error] = "Invalid company"
      redirect_to root_path
    end
  end

  def check_ownership
    check_company

    if @company.nil?
      flash[:error] = "Invalid url."
      redirect_to root_path
      return false
    end

    if current_user.nil?
      flash[:error] = "You must log in to access that page"
      redirect_to root_path
      return false
    end

    unless current_user.is_owner_for(@company)
      flash[:error] = "You must own '#{@company.name}' to access that page"
      redirect_to root_path
      false
    else
      true
    end
  end

  def is_owner?
    current_user.try(:is_owner_for, @company, current_user)
  end
end
