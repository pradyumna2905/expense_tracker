class Category < ApplicationRecord
  DEFAULT_CATEGORY = "Uncategorized".freeze
  belongs_to :user
  has_one :expense

  validates_presence_of :title

  def default_category?
    self.title == DEFAULT_CATEGORY
  end
end
