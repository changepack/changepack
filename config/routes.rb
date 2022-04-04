# typed: strict
Rails.application.routes.draw do
  root "changelogs#index"

  resources :changelogs do
    member do
      get :confirm_destroy
    end
  end
end
