Rails.application.routes.draw do
  root 'changelogs#index'

  devise_for :users, controllers: { registrations: 'registrations' }
  post '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

  resources :changelogs do
    member do
      get :confirm_destroy
    end
  end

  get ':id', to: 'accounts#show', as: :account

  unless Rails.env.production?
    scope path: '/__cypress__', controller: 'cypress' do
      post 'authenticate', action: 'authenticate'
    end
  end
end
