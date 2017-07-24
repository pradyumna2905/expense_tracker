require 'rails_helper'

RSpec.describe PaymentMethod, type: :model do
  it { should belong_to :user }
  it { should have_many :expenses }

  it { should validate_presence_of :name }

  describe '.monthly_expenses' do
    it 'returns expenses for the current month' do
    end
  end
end
