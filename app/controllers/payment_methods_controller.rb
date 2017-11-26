class PaymentMethodsController < ApplicationController
  before_action :require_user

  def new
    @payment_method = current_user.payment_methods.build
  end

  def create
    @payment_method = current_user.payment_methods.build(payment_method_params)

    if @payment_method.save
      redirect_to new_transaction_path
    else
      render :new
    end
  end

  def edit
    @payment_method = PaymentMethod.find(params[:payment_method_id])
  end

  def update
    @payment_method = PaymentMethod.find(params[:payment_method_id])
    if @payment_method.update(payment_method_params)
      redirect_to profile_user_path
    else
      render :edit
    end
  end

  def destroy
    payment_method = PaymentMethod.find(params[:payment_method_id])
    sync_transactions(payment_method)
    payment_method.destroy
    redirect_to profile_user_path(current_user)
  end

  private
  def payment_method_params
    params.require(:payment_method).permit(:name)
  end

  def sync_transactions(payment_method)
    current_user.transactions.each do |transaction|
      if transaction.payment_method_id == payment_method.id
        transaction.update_attributes!(
          payment_method_id: current_user.payment_methods.default.first.id
        )
      end
    end
  end
end
