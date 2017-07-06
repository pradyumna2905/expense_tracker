class Expense < ApplicationRecord
  # ============================== ASSOCIATIONS =============================
  belongs_to :user
  belongs_to :payment_method
  belongs_to :category

  # Because we want the latest first... obviously
  scope :desc, -> { order(date: :desc).order(created_at: :desc) }

  # ============================== VALIDATIONS  =============================
  validates_presence_of :date, :amount, :description
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { minimum: 2 }

  validate :future_expense

  accepts_nested_attributes_for :payment_method
  accepts_nested_attributes_for :category

  def future_expense
    # Dont allow future expenses for now
    if self.date.present? && self.date > Date.today
      errors.add(:date, "can't be in the future.")
    end
  end
end
