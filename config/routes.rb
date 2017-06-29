Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  resources :users, only: :none do
    member do
      resources :payment_methods, except: [:index, :show], path: 'wallet'
    end
  end

  resources :expenses
end
