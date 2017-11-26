require 'rails_helper'

RSpec.describe PaymentMethodsController, type: :controller do
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
      it 'creates a payment method record' do
        user = create_and_sign_in_user
        expect { post :create, params:
                 { id: user.id,
                   payment_method: attributes_for(:payment_method,
                                                  user: user) } }.
                 to change(PaymentMethod, :count).by 1

      end

      it 'redirects to index page' do
        user = create_and_sign_in_user
        post :create, params: { id: user.id,
                   payment_method: attributes_for(:payment_method,
                                                  user: user) }

        expect(response).to redirect_to new_transaction_path
      end
    end

    context 'with invalid params' do
      it 'does not create transaction record' do
        user = create_and_sign_in_user
        expect { post :create, params:
                 { id: user.id,
                   payment_method: attributes_for(:payment_method,
                                                  name: "",
                                                  user: user) } }.
                 to_not change(PaymentMethod, :count)

      end

      it 'renders the new template' do
        user = create_and_sign_in_user
        post :create, params: { id: user.id,
                   payment_method: attributes_for(:payment_method,
                                                  name: "",
                                                  user: user) }

        expect(response).to render_template :new
      end
    end
  end

  describe '#edit' do
    context 'when signed in' do
      it 'renders edit page' do
        user = create_and_sign_in_user
        payment_method = create(:payment_method, user: user)
        get :edit, params: { id: user.id, payment_method_id: payment_method.id }

        expect(response).to render_template :edit
        expect(assigns(:payment_method)).to eq payment_method
      end
    end

    context 'when signed out' do
      it 'renders sign in page' do
        get :edit, params: { id: 1, payment_method_id: 2 }

        expect(response).to redirect_to new_user_session_path
      end

      it 'populates flash with message' do
        get :edit, params: { id: 1, payment_method_id: 2 }

        expect(flash[:danger]).
          to eq "Please log in to continue!"
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'creates transaction record' do
        user = create_and_sign_in_user
        payment_method = create(:payment_method, user: user)

        put :update, params: { id: user.id,
                               payment_method_id: payment_method.id,
                               payment_method: attributes_for(
                                 :payment_method,
                                  user: user,
                                  name: "New") }

        expect(payment_method.reload.name).to eq "New"
        expect(response).to redirect_to profile_user_path
      end
    end

    context 'with invalid params' do
      it 'does not creates transaction record' do
        user = create_and_sign_in_user
        payment_method = create(:payment_method, name: "Old", user: user)

        put :update, params: { id: user.id,
                               payment_method_id: payment_method.id,
                               payment_method: attributes_for(
                                 :transaction,
                                  user: user,
                                  name: ""
        ) }

        expect(payment_method.reload.name).to eq "Old"
        expect(response).to render_template :edit
      end
    end
  end

  describe '#destroy' do
    it 'deletes the right record' do
      user = create_and_sign_in_user
      payment_method = create(:payment_method, name: "Old", user: user)

      expect { delete :destroy,
               params: { id: user.id,
                         payment_method_id: payment_method.id } }.
      to change(PaymentMethod, :count).by -1
    end

    it 'sets transaction related transaction payment method as the default payment method' do
      user = create_and_sign_in_user
      payment_method = create(:payment_method, name: "Old", user: user)
      transaction = create(:transaction, user: user, payment_method: payment_method)

      delete :destroy, params: { id: user.id,
                                 payment_method_id: payment_method.id }

      payment_method_transactions = user.transactions.where(
        payment_method_id: payment_method.id
      )
      expect(payment_method_transactions).to eq []
    end
  end

  def create_and_sign_in_user
    user = create(:user)
    sign_in user
    user
  end
end
