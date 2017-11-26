require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :transactions }
  it { should have_many :payment_methods }

  describe '.grand_total' do
    it 'returns total for all transactions' do
      user = create(:user)
      exp1 = create(:transaction, user: user, amount: 20)
      exp2 = create(:transaction, user: user, amount: 30)

      expect(user.grand_total).to eq 50
    end
  end
end
