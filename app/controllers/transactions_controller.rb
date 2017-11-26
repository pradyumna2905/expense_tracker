class TransactionsController < ApplicationController
  before_action :require_user
  before_action :set_transactions, except: [:new]

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = transactions.build(transaction_params)

    if @transaction.save
      redirect_to transactions_path
    else
      render :new
    end
  end

  def index
    _transactions = transactions.by_month(params[:month],
                                               params[:year]).
      includes(:payment_method, :category)
    @monthly_total = _transactions.total
    @transactions = Kaminari.paginate_array(_transactions).page(params[:page])
  end

  def edit
    @transaction = Transaction.find(params[:id])
  end

  def update
    @transaction = Transaction.find(params[:id])
    if @transaction.update(transaction_params)
      redirect_to transaction_path
    else
      render :edit
    end
  end

  def destroy
    @transaction = Transaction.find(params[:id]).destroy
    redirect_to transaction_path
  end

  private
  def set_transactions
    @transactions = current_user.transactions
  end

  def transactions
    @transactions
  end

  def transaction_params
    params.require(:transaction).permit(:date,
                             :amount,
                             :description,
                             :payment_method_id,
                             :category_id,
                             :user_id)
  end
end
