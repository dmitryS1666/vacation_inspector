Rails.application.routes.draw do
  devise_for :users
  resources :users, only: %i[show]
  resources :statements

  root to: "home#index"
end
