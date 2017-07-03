class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :expenses
  has_many :payment_methods
  has_many :categories

  accepts_nested_attributes_for :payment_methods

  after_create :set_default_payment_method

  def grand_total
    self.expenses.sum(:amount)
  end

  def default_payment_method
    self.payment_methods.where(name: PaymentMethod::DEFAULT_PAYMENT_METHOD).first
  end

  private

  def set_default_payment_method
    if self.payment_methods.blank?
      self.payment_methods.create(name: PaymentMethod::DEFAULT_PAYMENT_METHOD)
    end
  end
end
