class Transaction < ApplicationRecord
  SANITZED_YEARS = [*5.years.ago.year..Date.current.year].freeze
  # ============================== ASSOCIATIONS =============================
  belongs_to :user
  belongs_to :payment_method
  belongs_to :category

  # Because we want the latest first... obviously
  scope :desc, -> { order(date: :desc) }

  # ============================== VALIDATIONS  =============================
  validates_presence_of :date, :amount, :description
  validates :amount, numericality: { greater_than: 0 }
  validates :description, length: { minimum: 2 }

  validate :future_transaction

  accepts_nested_attributes_for :payment_method
  accepts_nested_attributes_for :category

  class << self
    def by_month(month, year)
      where(date: start_date(month, year)..end_date(month, year)).desc
    end

    def current_month
      by_month(Date.current, Date.current.year)
    end

    def total
      sum(:amount)
    end

    private
    def start_date(month, year)
      _month_index = month_index(month)
      _year = sanitize_year(year)

      Date.new(_year, _month_index, 1)
    end

    def end_date(month, year)
      start_date(month, year).end_of_month
    end

    def month_index(month)
      if Date::MONTHNAMES.compact.map(&:downcase).include?(month.to_s.downcase)
        Date::MONTHNAMES.index do |month_name|
          month_name&.downcase == month.to_s.downcase
        end
      else
        Date.current.month
      end
    end

    def sanitize_year(year)
      SANITZED_YEARS.include?(year.to_i) ? year.to_i : Date.current.year
    end
  end

  def future_transaction
    # Dont allow future transactions for now
    if self.date.present? && self.date > Date.current
      errors.add(:date, "can't be in the future.")
    end
  end
end
