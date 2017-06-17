require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
  describe '#current' do
    context 'when signed in' do
      before do
        create_and_sign_in_user
      end

      it 'renders the current page' do
        get :current

        expect(response).to render_template :current
      end
    end

    context 'when signed out' do
      it 'does not render current tempalte' do
        get :current

        expect(response).to_not render_template :current
      end

      it 'redirects to log in page' do
        get :current

        expect(response).to redirect_to(new_user_session_path)
      end

      it 'populates flash with message' do
        get :current

        expect(flash[:danger]).
          to eq "Please log in to continue!"
      end
    end
  end

  def create_and_sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end

