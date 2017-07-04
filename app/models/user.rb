class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :expenses, dependent: :destroy
  has_many :payment_methods, dependent: :destroy
  has_many :categories, dependent: :destroy

  accepts_nested_attributes_for :expenses

  def grand_total
    self.expenses.sum(:amount)
  end
end
