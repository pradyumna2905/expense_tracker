require 'rails_helper'

RSpec.describe Category, type: :model do
  it { should belong_to :user }
  it { should have_one :expense }

  it { should validate_presence_of :title }
end
