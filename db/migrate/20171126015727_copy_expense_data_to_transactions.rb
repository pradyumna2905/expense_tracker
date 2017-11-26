class CopyExpenseDataToTransactions < ActiveRecord::Migration[5.0]
  def change
    Expense.all.each do |expense|
      Transaction.create!(
        date: expense.date,
        amount: expense.amount,
        description: expense.description,
        payment_method_id: expense.payment_method_id,
        category_id: expense.category_id,
        user_id: expense.user_id,
        created_at: expense.created_at,
        updated_at: expense.updated_at
      )
    end
  end
end
