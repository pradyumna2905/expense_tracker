class Category < ApplicationRecord
  DEFAULT_CATEGORY = "Uncategorized".freeze

  scope :weekly_expense_report, -> { group(:title).joins(:expenses).
    where("expenses.date >= ?", 1.week.ago) }

  belongs_to :user
  has_many :expenses

  validates_presence_of :title

  def default_category?
    self.title == DEFAULT_CATEGORY
  end
end
