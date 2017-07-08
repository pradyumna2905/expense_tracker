Rails.application.routes.draw do
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
  devise_for :users

  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  resources :users, only: :none do
    member do
      resources :payment_methods, except: [:index, :show], path: 'wallet'
      resources :categories, except: [:index, :show]
    end
  end

  namespace :dashboards do
    get :current
    get :trends
  end
  resources :expenses
end
