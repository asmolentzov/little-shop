Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/cart', to: "carts#show"
  get '/login', to: "sessions#new"
  get '/register', as: :registration, to: "users#new"
  get '/profile', as: :profile, to: "users#show"

  resources :items, only: [:index]
  resources :users, as: :merchants, only: [:index]
  resources :users, only: [:update]
end
