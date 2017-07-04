require 'rails_helper'

RSpec.describe Expense, type: :model do
  it { should belong_to :user }
  it { should belong_to :payment_method }
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

  describe ".set_default_payment_method" do
    it "sets default payment method if payment method not present" do
      expense = create(:expense,
                       payment_method_id: nil,
                       user: create(:user))

      expense.reload
      expect(expense.payment_method.name).
        to eq "Cash"
    end
  end

  describe ".set_default_category" do
    it "sets default category if not present" do
      expense = create(:expense,
                       category_id: nil,
                       user: create(:user))

      expense.reload
      expect(expense.category.title).
        to eq "Uncategorized"
    end
  end
end
