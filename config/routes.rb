require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  constraints CustomDomain do
    root to: 'accounts#show', as: :custom_domain
    resources :posts, only: [:show]
  end

  authenticate do
    root 'accounts#index'

    resources :accounts, only: [:index]

    resources :posts, except: [:show] do
      member do
        get :confirm_destroy
      end
    end

    resources :sources, only: [:index]
    resources :repositories, only: [:update, :destroy] do
      member do
        get :confirm_destroy
        get :confirm_update
      end
    end
  end

  resources :posts, only: [:show]

  mount Sidekiq::Web => 'sidekiq'

  if Rails.env.test?
    scope path: '__cypress__', controller: 'users/cypress' do
      post 'authenticate', action: 'authenticate'
    end
  end

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  # Both a public and a private URL to your changelog.
  # Has to be at the end so that all other routes are matched first.
  get ':id', to: 'accounts#show', as: :account
end
