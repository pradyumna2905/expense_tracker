class DashboardsController < ApplicationController
  before_action :require_user

  def current
    @expenses = current_user.expenses
    @payment_methods = current_user.payment_methods
  end

  def trends

  end
end
