require 'rails_helper'

RSpec.describe ExpensesController, type: :controller do
  describe '#new' do
    context 'when signed in' do
      it 'renders new page' do
        user = create(:user)
        sign_in user
        get :new

        expect(response).to render_template :new
      end
    end

    context 'when signed out' do
      it 'redirects to log in page' do
        get :new

        expect(response).to redirect_to(new_user_session_path)
      end

      it 'populates flash with message' do
        get :new

        expect(flash[:danger]).
          to eq "You need to be logged in to view your expenses!"
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates an expense record' do
        expect { post :create, params:
                 { expense: attributes_for(:expense, user: sign_in_user) } }.
                 to change(Expense, :count).by 1

      end
    end
  end

  def sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end
