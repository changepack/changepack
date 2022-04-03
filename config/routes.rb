# typed: strict
Rails.application.routes.draw do
  root "changelogs#index"

  resources :changelogs
end
