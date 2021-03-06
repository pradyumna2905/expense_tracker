class CategoriesController < ApplicationController
  before_action :require_user

  def new
    @category = current_user.categories.build
  end

  def create
    @category = current_user.categories.build(category_params)

    if @category.save
      redirect_to new_transaction_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:category_id])
  end

  def update
    @category = Category.find(params[:category_id])
    if @category.update(category_params)
      redirect_to profile_user_path
    else
      render :edit
    end
  end

  def destroy
    category = Category.find(params[:category_id])
    sync_transactions(category)
    category.destroy
    redirect_to profile_user_path(current_user)
  end

  private

  def category_params
    params.require(:category).permit(:title)
  end

  def sync_transactions(category)
    current_user.transactions.each do |transaction|
      if transaction.category == category
        transaction.update_attributes!(
          category_id: current_user.categories.default.first.id
        )
      end
    end
  end
end
