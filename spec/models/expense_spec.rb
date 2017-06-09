require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { should belong_to :user }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:amount) }

  it { should validate_numericality_of(:amount).is_greater_than(0) }
  it { should validate_length_of(:description).is_at_least(2) }

  describe ".not_in_future" do
    it "validates that date entered is not in future" do
      user = create(:user)
      expense = build(:expense,
                      user: create(:user),
                      date: 2.days.from_now)


      expect(expense).to_not be_valid
    end
  end
end
