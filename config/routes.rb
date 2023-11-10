require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  namespace :api do
    namespace :v1 do
      resources :posts, only: :create
      resources :images, only: :create
    end
  end

  authenticate do
    root 'posts#index'

    resources :accounts, only: :index
    resources :posts do
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

  mount Sidekiq::Web => 'sidekiq'

  if Rails.env.test?
    scope path: '__cypress__', controller: 'users/cypress' do
      post 'authenticate', action: 'authenticate'
    end
  end

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end
end
