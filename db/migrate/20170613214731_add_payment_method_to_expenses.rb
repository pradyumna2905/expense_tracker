class AddPaymentMethodToExpenses < ActiveRecord::Migration[5.0]
  def change
    add_reference :expenses, :payment_method, foreign_key: true
  end
end
