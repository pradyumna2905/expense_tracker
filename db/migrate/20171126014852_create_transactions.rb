class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.datetime :date
      t.decimal :amount
      t.string :description
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true
      t.references :payment_method, index: true, foreign_key: true

      t.timestamps
    end
  end
end
