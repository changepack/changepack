require 'sidekiq/web'

Rails.application.routes.draw do
  root 'changelogs#index'

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :changelogs do
    member do
      get :confirm_destroy
    end
  end

  resources :repositories, only: [:index, :show, :update, :destroy]

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
