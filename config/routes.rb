Rails.application.routes.draw do
  resources :repositories
  root 'changelogs#index'

  devise_for :users, controllers: { registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :changelogs do
    member do
      get :confirm_destroy
    end
  end

  get ':id', to: 'accounts#show', as: :account

  unless Rails.env.production?
    scope path: '__cypress__', controller: 'users/cypress' do
      post 'authenticate', action: 'authenticate'
    end
  end
end
