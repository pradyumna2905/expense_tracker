class ExpensesController < ApplicationController
  before_action :require_user
  before_action :set_expenses, except: [:new]

  def new
    @expense = Expense.new
  end

  def create
    @expense = expenses.build(expense_params)

    if @expense.save
      redirect_to expenses_path
    else
      render :new
    end
  end

  def index
    _expenses = expenses.by_month(params[:month],
                                               params[:year]).
      includes(:payment_method, :category)
    @monthly_total = _expenses.total
    @expenses = Kaminari.paginate_array(_expenses).page(params[:page])
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
  def set_expenses
    @expenses = current_user.expenses
  end

  def expenses
    @expenses
  end

  def expense_params
    params.require(:expense).permit(:date,
                             :amount,
                             :description,
                             :payment_method_id,
                             :category_id,
                             :user_id)
  end
end
