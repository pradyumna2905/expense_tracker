class ExpensesController < ApplicationController
  before_action :require_user

  def new
    @expense = Expense.new
  end

  def create
    @user = current_user
    @expense = @user.expenses.build(expense_params)

    if @expense.save
      redirect_to expenses_path
    else
      render :new
    end
  end

  def index
    @user = current_user
    @grand_total = @user.grand_total
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update(expense_params)
      redirect_to expenses_path
    else
      render :edit
    end
  end

  private

  def expense_params
    params.require(:expense).permit(:date,
                             :amount,
                             :description,
                             :user_id)
  end

  def require_user
    user_signed_in?
  end
end
