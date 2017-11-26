class Category < ApplicationRecord
  DEFAULT_CATEGORY = "Uncategorized".freeze

  scope :default, -> { where(title: DEFAULT_CATEGORY) }

  belongs_to :user
  has_many :transactions

  validates_presence_of :title

  def default_category?
    self.title == DEFAULT_CATEGORY
  end

  class << self
    def monthly_transactions
      group(:title).joins(:transactions).
        where("transactions.date >= ?", Date.current.beginning_of_month)
    end
  end
end
