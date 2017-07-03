class Category < ApplicationRecord
  DEFAULT_CATEGORY = "Uncateogrized".freeze
  belongs_to :expense

  def set_as_default
    self.title = DEFAULT_CATEGORY
  end
end
