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
        user = create_and_sign_in_user
        expect { post :create, params:
                 { id: user.id,
                   category: attributes_for(:category,
                                            user: user) } }.
                 to change(Category, :count).by 1

      end

      it 'redirects to index page' do
        user = create_and_sign_in_user
        post :create, params: { id: user.id,
                   category: attributes_for(:category,
                                            user: user) }

        expect(response).to redirect_to new_transaction_path
      end
    end

    context 'with invalid params' do
      it 'does not creates a transaction record' do
        user = create_and_sign_in_user
        expect { post :create, params:
                 { id: user.id,
                   category: attributes_for(:category,
                                            title: "",
                                            user: user) } }.
                 to_not change(Category, :count)

      end

      it 'renders the new template' do
        user = create_and_sign_in_user
        post :create, params: { id: user.id,
                   category: attributes_for(:category,
                                            title: "",
                                            user: user) }

        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do
    context 'when signed in' do
      it 'renders edit page' do
        user = create_and_sign_in_user
        category = create(:category, user: user)
        get :edit, params: { id: user.id, category_id: category.id }

        expect(response).to render_template :edit
        expect(assigns(:category)).to eq category
      end
    end

    context 'when signed out' do
      it 'renders sign in page' do
        get :edit, params: { id: 1, category_id: 1 }

        expect(response).to redirect_to new_user_session_path
      end

      it 'populates flash with message' do
        get :edit, params: { id: 1, category_id: 1 }

        expect(flash[:danger]).
          to eq "Please log in to continue!"
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'creates a transaction record' do
        user = create_and_sign_in_user
        category = create(:category, user: user)

        put :update, params: { id: user.id,
                               category_id: category.id,
                               category: attributes_for(
                                 :category,
                                  user: user,
                                  title: "New") }

        expect(category.reload.title).to eq "New"
        expect(response).to redirect_to profile_user_path
      end
    end

    context 'with invalid params' do
      it 'does not creates a transaction record' do
        user = create_and_sign_in_user
        category = create(:category, title: "Old", user: user)

        put :update, params: { id: user.id,
                               category_id: category.id,
                               category: attributes_for(
                                 :transaction,
                                  user: user,
                                  title: ""
        ) }

        expect(category.reload.title).to eq "Old"
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    it 'deletes the right record' do
      user = create_and_sign_in_user
      category = create(:category, title: "Old", user: user)

      expect { delete :destroy,
               params: { id: user.id,
                         category_id: category.id } }.
      to change(Category, :count).by -1
    end

    it 'sets transaction related transaction payment method as the default payment method' do
      user = create_and_sign_in_user
      category = create(:category, title: "Old", user: user)
      transaction = create(:transaction, user: user, category: category)

      delete :destroy, params: { id: user.id,
                                 category_id: category.id }

      category_transactions = user.transactions.where(
        category_id: category.id
      )
      expect(category_transactions).to eq []
    end
  end

  def create_and_sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end
