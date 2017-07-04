class Expense < ApplicationRecord
  # ============================== ASSOCIATIONS =============================
  belongs_to :user
  belongs_to :payment_method, dependent: :destroy

  # Because we want the latest first... obviously
  scope :desc, -> { order(date: :desc) }

  # ============================== VALIDATIONS  =============================
  validates_presence_of :date, :amount, :description
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { minimum: 2 }

  validate :future_expense
  before_validation :set_default_payment_method
  accepts_nested_attributes_for :payment_method

  def future_expense
    # Dont allow future expenses for now
    if self.date.present? && self.date > Date.today
      errors.add(:date, "can't be in the future.")
    end
  end

  private

  def set_default_payment_method
    if self.payment_method_id.blank?
      self.build_payment_method(
        name: PaymentMethod::DEFAULT_PAYMENT_METHOD,
        user: self.user
      )
    end
  end
end
