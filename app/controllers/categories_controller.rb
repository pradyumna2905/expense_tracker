class CategoriesController < ApplicationController
  before_action :require_user
  def new
    @category = current_user.payment_methods.build
  end

  def create
    @payment_method = current_user.payment_methods.build(create_params)

    if @payment_method.save
      redirect_to new_expense_path
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:payment_method).permit(:name)
  end
end
