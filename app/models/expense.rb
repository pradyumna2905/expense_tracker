class Expense < ApplicationRecord
  # ============================== ASSOCIATIONS =============================
  belongs_to :user
  belongs_to :payment_method, optional: true
  has_one :category, dependent: :destroy

  accepts_nested_attributes_for :category
  # Because we want the latest first... obviously
  scope :desc, -> { order(date: :desc) }

  # ============================== VALIDATIONS  =============================
  validates_presence_of :date, :amount, :description
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { minimum: 2 }

  validate :future_expense
  before_create :set_default_payment_method
  before_create :set_default_category

  def future_expense
    # Dont allow future expenses for now
    if self.date.present? && self.date > Date.today
      errors.add(:date, "can't be in the future.")
    end
  end

  private

  def set_default_payment_method
    if self.payment_method_id.blank?
      self.payment_method = self.user.default_payment_method
    end
  end

  def set_default_category
    if self.category.blank?
      self.build_category(title: Category::DEFAULT_CATEGORY)
    end
  end
end
