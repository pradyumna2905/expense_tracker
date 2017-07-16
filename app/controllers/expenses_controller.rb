class ExpensesController < ApplicationController
  before_action :require_user

  def new
    @expense = Expense.new
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to expenses_path
    else
      render :new
    end
  end

  def index
    @expenses = current_user.expenses.by_month(params[:month],
                                               params[:year]).
      includes(:payment_method, :category).page(params[:page])
    @grand_total = current_user.grand_total
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

  def destroy
    @expense = Expense.find(params[:id]).destroy
    redirect_to expenses_path
  end

  private

  def expense_params
    params.require(:expense).permit(:date,
                             :amount,
                             :description,
                             :payment_method_id,
                             :category_id,
                             :user_id)
  end
end
