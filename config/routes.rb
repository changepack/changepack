require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  constraints Domain do
    scope as: :domain do
      root to: 'accounts#show'

      resources :posts, only: :show
      resources :changelogs, only: :show, path: ''
    end
  end

  namespace :api do
    namespace :v1 do
      resources :posts, only: :create
      resources :images, only: :create
    end
  end

  authenticate do
    root 'accounts#index'

    resources :accounts, only: :index

    resources :changelogs, only: [:index, :show, :edit, :update]

    resources :posts, except: :show do
      member do
        get :confirm_destroy
      end
    end

    resources :sources, only: :index
    resources :repositories, only: [:update, :destroy] do
      member do
        get :confirm_destroy
        get :confirm_update
      end
    end
    resources :teams, only: [:update, :destroy] do
      member do
        get :confirm_destroy
        get :confirm_update
      end
    end
  end

  get 'posts/:id', to: 'posts#show', as: :deprecated_post

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
  scope path: ':account_id', as: :account do
    root 'accounts#show', as: ''

    resources :posts, only: :show
    resources :changelogs, only: :show, path: ''
  end
end
