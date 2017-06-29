class PaymentMethod < ApplicationRecord
  DEFAULT_PAYMENT_METHOD = "Cash"

  belongs_to :user
  has_many :expenses

  validates_presence_of :name

  def default_payment_method?
    self.name == DEFAULT_PAYMENT_METHOD
  end
end
