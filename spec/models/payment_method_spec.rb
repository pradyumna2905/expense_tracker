require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it { should belong_to :user }
  it { should have_many :transactions }

  it { should validate_presence_of :name }

  describe '.monthly_transactions' do
    it 'returns transactions for the current month' do
    end
  end
end
