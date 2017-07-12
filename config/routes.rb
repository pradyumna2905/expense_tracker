Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/registrations#new'
  end

  resources :users, only: :none do
    member do
      resources :payment_methods, except: [:index, :show],
        path: 'wallet', param: :payment_method_id
      resources :categories, except: [:index, :show], param: :category_id

      get '/profile', to: 'profiles#show'
    end
  end

  namespace :dashboards do
    get :current
    get :trends
  end
  resources :expenses
end
