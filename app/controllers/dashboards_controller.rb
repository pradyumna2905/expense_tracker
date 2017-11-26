class DashboardsController < ApplicationController
  before_action :require_user

  def current
    @transactions = current_user.transactions
    @payment_methods = current_user.payment_methods
    @categories = current_user.categories
  end

  def trends

  end
end
