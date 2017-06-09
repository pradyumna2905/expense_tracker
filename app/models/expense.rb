class Expense < ApplicationRecord
  belongs_to :user

  # Because we want the latest first... obviously
  default_scope { order(date: :desc) }
end
