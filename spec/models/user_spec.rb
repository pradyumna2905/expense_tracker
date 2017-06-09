require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many :expenses }
  
  describe '.grand_total' do
    it 'returns total for all expenses' do
      user = create(:user)
      exp1 = create(:expense, user: user, amount: 20)
      exp2 = create(:expense, user: user, amount: 30)

      expect(user.grand_total).to eq 50
    end
  end
end
