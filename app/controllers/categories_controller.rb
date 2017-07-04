class CategoriesController < ApplicationController
  before_action :require_user

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(create_params)

    if @category.save
      redirect_to new_expense_path
    else
      render :new
    end
  end

  private

  def create_params
    params.require(:category).permit(:title)
  end
end
