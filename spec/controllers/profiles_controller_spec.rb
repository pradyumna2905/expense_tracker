require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  describe '#show' do
    context 'when user logged in' do
      let(:user) { create(:user) }

      before do
        sign_in user
        get :show, params: { id: user.id }
      end

      it 'renders the profile show page' do
        expect(response).to render_template :show
      end
    end
  end
end
