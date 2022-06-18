Rails.application.routes.draw do
  root 'changelogs#index'

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  # Both a public and a private URL to your changelog.
  get ':id', to: 'accounts#show', as: :account

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
end
