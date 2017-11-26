require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
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
      let(:user) { create_and_sign_in_user }
      it 'creates transaction record' do
        expect { post :create, params:
                 { transaction: attributes_for(:transaction, user: user) } }.
                 to change(Transaction, :count).by 1

      end

      it 'redirects to index page' do
        post :create, params: { transaction: attributes_for(:transaction,
                                                        user: user) }

        expect(response).to redirect_to transactions_path
      end
    end

    context 'with invalid params' do
      let(:user) { create_and_sign_in_user }
      it 'does not creates transaction record' do
        expect { post :create, params:
                 { transaction: attributes_for(:transaction,
                                           user: user,
                                           date: Date.tomorrow) } }.
                 to_not change(Transaction, :count)

      end

      it 'renders the new template' do
        post :create, params: { transaction: attributes_for(:transaction,
                                                        amount: nil,
                                                        user: user) }

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

      it 'displays all the transactions in desc order' do
        user = create_and_sign_in_user
        transaction_today = create(:transaction, user: user,
                               date: Date.today)
        transaction_oldest = create(:transaction, user: user,
                                date: 4.days.ago)
        transaction_old = create(:transaction, user: user,
                               date: Date.yesterday)
        get :index

        expect(assigns(:transactions)).to(
             eq([transaction_today, transaction_old, transaction_oldest]))
      end

      it 'sets the total for the transactions' do
        user = create_and_sign_in_user
        create(:transaction, user: user, amount: 15, date: Date.current)
        create(:transaction, user: user, amount: 30, date: Date.current)
        create(:transaction, amount: 100, user: user, date: 1.month.ago)
        get :index

        expect(assigns(:monthly_total)).to eq 45
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
        transaction = create(:transaction, user: user)
        get :edit, params: { id: transaction.id }

        expect(response).to render_template :edit
        expect(assigns(:transaction)).to eq transaction
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
      it 'creates a transaction record' do
        user = create_and_sign_in_user
        transaction = create(:transaction, user: user)

        put :update, params: { id: transaction.id,
                               transaction: attributes_for(:transaction,
                                                       user: user,
                                                       description: "New") }

        expect(transaction.reload.description).to eq "New"
        expect(response).to redirect_to transaction_path
      end
    end

    context 'with invalid params' do
      it 'does not creates transaction record' do
        user = create_and_sign_in_user
        transaction = create(:transaction, description: "Old", user: user)

        put :update, params: { id: transaction.id,
                               transaction: attributes_for(:transaction,
                                                       user: user,
                                                       description: "") }

        expect(transaction.reload.description).to eq "Old"
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    it 'finds the right record' do
      user = create_and_sign_in_user
      transaction = create(:transaction, description: "Old", user: user)
      delete :destroy, params: { id: transaction.id }

      expect(assigns(:transaction)).to eq transaction
    end

    it 'deletes the right record' do
      user = create_and_sign_in_user
      transaction = create(:transaction, description: "Old", user: user)

      expect { delete :destroy,
               params: { id: transaction.id } }.
      to change(Transaction, :count).by -1
    end
  end

  def create_and_sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end
