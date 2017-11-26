class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :transactions, dependent: :destroy
  has_many :payment_methods, dependent: :destroy
  has_many :categories, dependent: :destroy

  accepts_nested_attributes_for :transactions

  after_create do
    create_default_payment_method
    create_default_category
  end

  def grand_total
    self.transactions.sum(:amount)
  end

  def default_category
    self.categories.default
  end

  def default_payment_method
    self.payment_methods.default
  end

  private

  def create_default_payment_method
    # Safety sanity check
    if self.payment_methods.blank?
      self.payment_methods.create(name: PaymentMethod::DEFAULT_PAYMENT_METHOD)
    end
  end

  def create_default_category
    # Safety sanity check
    if self.categories.blank?
      self.categories.create(title: Category::DEFAULT_CATEGORY)
    end
  end
end
