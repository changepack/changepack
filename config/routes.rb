# typed: false
Rails.application.routes.draw do
  devise_for :users
  root 'changelogs#index'

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
