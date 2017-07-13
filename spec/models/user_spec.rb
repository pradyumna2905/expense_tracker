require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :expenses }
  it { should have_many :payment_methods }

  describe '.grand_total' do
    it 'returns total for all expenses' do
      user = create(:user)
      exp1 = create(:expense, user: user, amount: 20)
      exp2 = create(:expense, user: user, amount: 30)

      expect(user.grand_total).to eq 50
    end
  end

  describe '.monthly_expenses' do
    context 'assuming clean params' do
      it 'returns monthly expenses for the correct month' do
        user = create(:user)
        expense_date = 3.months.ago
        current_month_expenses = create(:expense,
                                        date: expense_date,
                                        user: user)
        last_month_expenses = create(:expense, date: 1.month.ago, user: user)

        expect(user.monthly_expenses(expense_date.strftime("%B"),
                                     Date.current.year)).
              to_not include last_month_expenses
      end

      it 'handles case sensitive month names' do
        user = create(:user)
        expense_date = 3.months.ago
        current_month_expenses = create(:expense,
                                        date: expense_date,
                                        user: user)
        last_month_expenses = create(:expense, date: 1.month.ago, user: user)

        # Upcase 3rd character because minimum characters of a month name is 3.
        #
        # 'May' if you're trying to think :)
        expect(user.monthly_expenses(expense_date.strftime("%B").upcase,
                                     Date.current.year)).
              to eq [current_month_expenses]
      end
    end

    context 'assuming garbage params from the controller' do
      it 'returns monthly expenses for the current month' do
        user = create(:user)
        expense_date = Date.current
        current_month_expenses_1 = create(:expense,
                                        date: expense_date,
                                        user: user)
        current_month_expenses_2 = create(:expense,
                                        date: expense_date,
                                        user: user)
        last_month_expenses = create(:expense, date: 1.month.ago, user: user)

        expect(user.monthly_expenses("garbage_here",
                                     Date.current.year)).
              to eq [current_month_expenses_1, current_month_expenses_2]
      end
    end
  end
end
