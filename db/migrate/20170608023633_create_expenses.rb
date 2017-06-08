class CreateExpenses < ActiveRecord::Migration[5.0]
  def change
    create_table :expenses do |t|
      t.datetime :date
      t.decimal :amount
      t.string :description

      t.timestamps
    end
  end
end
