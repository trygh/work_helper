class DashboardController < ApplicationController

  before_filter :authenticate_user!

  def index
    @page = DashboardPage.new(current_user)
  end
end
