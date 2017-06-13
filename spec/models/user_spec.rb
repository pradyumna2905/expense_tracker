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

  describe ".set_default_payment_method" do
    it "sets default payment method if payment method not present" do
      user = create(:user)

      user.reload
      expect(user.payment_methods.last.name).
        to eq "Cash"
    end
  end
end
