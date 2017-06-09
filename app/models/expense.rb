class Expense < ApplicationRecord
  # ============================== ASSOCIATIONS =============================
  belongs_to :user

  # Because we want the latest first... obviously
  default_scope { order(date: :desc) }

  # ============================== VALIDATIONS  =============================
  validates_presence_of :date, :amount, :description
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { minimum: 2 }

  validate :future_expense

  def future_expense
    # Dont allow future expenses for now
    if self.date.present? && self.date > Date.today
      errors.add(:date, "can't be in the future.")
    end
  end
end
