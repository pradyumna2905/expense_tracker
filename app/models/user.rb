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

  after_create do
    create_default_payment_method
    create_default_category
  end

  def grand_total
    self.expenses.sum(:amount)
  end

  def default_category
    self.categories.default
  end

  def default_payment_method
    self.payment_methods.default
  end

  def monthly_expenses(month, year)
    month_index = month_index(month)

    start_date = start_date(month_index, year)
    end_date = start_date.end_of_month

    expenses.where(date: start_date..end_date)
  end

  private

  # TODO move these from here in utilities or do something about them asap.
  def month_index(month)
    index = Date::MONTHNAMES.index { |month_name| month_name =~ /month/i }
    binding.pry
    (index.present? && index.is_a?(Integer)) ? index : Date.current.month
  end

  def start_date(month_index, year)
    Date.new(year, month_index, 1)
  end

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
