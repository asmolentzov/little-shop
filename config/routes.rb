Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/cart', to: "carts#show"
  get '/login', to: "sessions#new"
  get '/register', as: :registration, to: "users#new"

  resources :items, only: [:index]
  resources :users, as: :merchants, only: [:index]
  resources :users, only: [:show] do
    resources :orders, only: [:index]
  end
end
