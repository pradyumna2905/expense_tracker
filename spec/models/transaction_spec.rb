require 'rails_helper'

RSpec.describe Transaction, type: :model do
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
      transaction = build(:transaction,
                      user: create(:user),
                      date: 2.days.from_now)

      expect(transaction).to_not be_valid
    end
  end

  describe '.by_month' do
    context 'when passed valid params' do
      it 'returns the transactions for that month and year' do
        user = create(:user)
        month_transaction = create(:transaction, user: user, date: 2.months.ago)
        excluded_month_transaction = create(:transaction,
                                        user: user,
                                        date: Date.current)

        # Passed in as strings
        expect(user.transactions.by_month(2.months.ago.strftime("%B"),
                                      Date.current.year.to_s)).
                                     to_not include excluded_month_transaction
        expect(user.transactions.by_month(2.months.ago.strftime("%B"),
                                      Date.current.year.to_s)).
                                     to include month_transaction
      end
    end

    context 'when passed invalid params' do
      it 'returns current months transactions' do
        user = create(:user)
        current_month_transaction = create(:transaction, user: user, date: Date.current)
        prev_month_transaction = create(:transaction,
                                    user: user,
                                    date: 1.month.ago)

        expect(user.transactions.by_month("Mayy", nil)).
          to include current_month_transaction
        expect(user.transactions.by_month(nil, nil)).
          to_not include prev_month_transaction
      end
    end
  end

  describe '.total' do
    it 'returns the total amount for the transactions' do
      user = create(:user)
      create(:transaction, user: user, amount: 15, date: Date.current)
      create(:transaction, user: user, amount: 30, date: Date.current)
      create(:transaction, amount: 100, user: user, date: 1.month.ago)

      expect(user.transactions.by_month(nil, nil).total).to eq 45
    end
  end
end
