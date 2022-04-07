Rails.application.routes.draw do
  root 'changelogs#index'

  devise_for :users, controllers: { registrations: 'registrations' }

  resources :changelogs do
    member do
      get :confirm_destroy
    end
  end

  unless Rails.env.production?
    scope path: '/__cypress__', controller: 'cypress' do
      post 'authenticate', action: 'authenticate'
    end
  end
end
