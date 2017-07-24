class PaymentMethod < ApplicationRecord
  DEFAULT_PAYMENT_METHOD = "Cash".freeze

  scope :default, -> { where(name: DEFAULT_PAYMENT_METHOD) }

  belongs_to :user
  has_many :expenses

  validates_presence_of :name

  def default_payment_method?
    self.name == DEFAULT_PAYMENT_METHOD
  end

  class << self
    def monthly_expenses
      group(:name).joins(:expenses).
        where("expenses.date >= ?", Date.current.beginning_of_month)
    end
  end
end
