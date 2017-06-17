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
          to eq "Please log in to continue!"
      end
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates an expense record' do
        expect { post :create, params:
                 { expense: attributes_for(:expense, user: create_and_sign_in_user) } }.
                 to change(Expense, :count).by 1

      end

      it 'redirects to index page' do
        post :create, params: { expense: attributes_for(:expense,
                                                        user: create_and_sign_in_user) }

        expect(response).to redirect_to expenses_path
      end
    end

    context 'with invalid params' do
      it 'does not creates an expense record' do
        expect { post :create, params:
                 { expense: attributes_for(:expense, user: nil) } }.
                 to_not change(Expense, :count)

      end

      it 'renders the new template' do
        post :create, params: { expense: attributes_for(:expense,
                                                        amount: nil,
                                                        user: create_and_sign_in_user) }

        expect(response).to render_template :new
      end
    end
  end

  describe '#index' do
    context 'when signed in' do
      it 'renders index page' do
        create_and_sign_in_user
        get :index

        expect(response).to render_template :index
      end

      it 'displays all the transactions' do
        user = create_and_sign_in_user
        get :index

        expect(assigns(:expenses)).to(
             eq(user.expenses))
      end
    end

    context 'when signed out' do
      it 'renders sign in page' do
        get :index

        expect(response).to redirect_to new_user_session_path
      end

      it 'populates flash with message' do
        get :index

        expect(flash[:danger]).
          to eq "Please log in to continue!"
      end
    end
  end

  describe '#edit' do
    context 'when signed in' do
      it 'renders edit page' do
        user = create_and_sign_in_user
        expense = create(:expense, user: user)
        get :edit, params: { id: expense.id }

        expect(response).to render_template :edit
        expect(assigns(:expense)).to eq expense
      end
    end

    context 'when signed out' do
      it 'renders sign in page' do
        get :edit, params: { id: 5 }

        expect(response).to redirect_to new_user_session_path
      end

      it 'populates flash with message' do
        get :edit, params: { id: 5 }

        expect(flash[:danger]).
          to eq "Please log in to continue!"
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'creates an expense record' do
        user = create_and_sign_in_user
        expense = create(:expense, user: user)

        put :update, params: { id: expense.id,
                               expense: attributes_for(:expense,
                                                       description: "New") }

        expect(expense.reload.description).to eq "New"
        expect(response).to redirect_to expenses_path
      end
    end

    context 'with invalid params' do
      it 'does not creates an expense record' do
        user = create_and_sign_in_user
        expense = create(:expense, description: "Old", user: user)

        put :update, params: { id: expense.id,
                               expense: attributes_for(:expense,
                                                       description: "") }

        expect(expense.reload.description).to eq "Old"
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    it 'finds the right record' do
      user = create_and_sign_in_user
      expense = create(:expense, description: "Old", user: user)
      delete :destroy, params: { id: expense.id }

      expect(assigns(:expense)).to eq expense
    end

    it 'deletes the right record' do
      user = create_and_sign_in_user
      expense = create(:expense, description: "Old", user: user)

      expect { delete :destroy,
               params: { id: expense.id } }.
      to change(Expense, :count).by -1
    end
  end

  def create_and_sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end
