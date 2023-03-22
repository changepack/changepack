require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  authenticate do
    root 'accounts#index'

    resources :accounts, only: [:index]

    resources :posts, except: [:show] do
      member do
        get :confirm_destroy
      end
    end

    resources :repositories, only: [:index, :update, :destroy] do
      member do
        get :confirm_destroy
        get :confirm_update
      end
    end
  end

  resources :posts, only: [:show]

  unless Rails.env.production?
    scope path: '__cypress__', controller: 'users/cypress' do
      post 'authenticate', action: 'authenticate'
    end
  end

  mount Sidekiq::Web => 'sidekiq'

  # Both a public and a private URL to your changelog.
  # Has to be at the end so that all other routes are matched first.
  get ':id', to: 'accounts#show', as: :account
end
