require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe '#new' do
    let(:user) { create(:user) }

    context 'when signed in' do
      it 'renders new page' do
        sign_in user
        get :new, params: { id: user.id }

        expect(response).to render_template :new
      end
    end

    context 'when signed out' do
      it 'redirects to log in page' do
        get :new, params: { id: 5 }

        expect(response).to redirect_to(new_user_session_path)
      end

      it 'populates flash with message' do
        get :new, params: { id: 5 }

        expect(flash[:danger]).
          to eq "Please log in to continue!"
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a category record' do
        user = sign_in_user
        expect { post :create, params:
                 { id: user.id,
                   category: attributes_for(:category,
                                            user: user) } }.
                 to change(Category, :count).by 1

      end

      it 'redirects to index page' do
        user = sign_in_user
        post :create, params: { id: user.id,
                   category: attributes_for(:category,
                                            user: user) }

        expect(response).to redirect_to new_expense_path
      end
    end

    context 'with invalid params' do
      it 'does not creates an expense record' do
        user = sign_in_user
        expect { post :create, params:
                 { id: user.id,
                   category: attributes_for(:category,
                                            title: "",
                                            user: user) } }.
                 to_not change(Category, :count)

      end

      it 'renders the new template' do
        user = sign_in_user
        post :create, params: { id: user.id,
                   category: attributes_for(:category,
                                            title: "",
                                            user: user) }

        expect(response).to render_template :new
      end
    end
  end

  def sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end
