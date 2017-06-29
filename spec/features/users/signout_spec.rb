require 'rails_helper'

describe 'User signs out' do
  let(:user) { create(:user) }

  before do
    sign_in(user)
  end

  it 'signs out user' do
    # TODO(PD)
  end
end
