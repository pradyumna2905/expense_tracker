class PaymentMethod < ApplicationRecord
  DEFAULT_PAYMENT_METHOD = "Cash"

  scope :weekly_expense_report, -> { group(:name).joins(:expenses).
    where("expenses.date >= ?", 1.week.ago) }

  belongs_to :user
  has_many :expenses

  validates_presence_of :name

  def default_payment_method?
    self.name == DEFAULT_PAYMENT_METHOD
  end
end
