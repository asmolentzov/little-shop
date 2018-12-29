Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/cart', to: "carts#show"
  delete '/cart', to: "carts#destroy"
  patch '/cart/item', to: "carts#update"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', as: :registration, to: "users#new"
  delete '/logout', to: "sessions#destroy"
  get '/merchants', as: :merchants, to: "users#index"
  get '/dashboard', as: :dashboard, to: "users#show"
  get '/dashboard/items', to: "items#index"
  get '/dashboard/orders/:id', as: :dashboard_orders, to: "orders#show"
  put '/dashboard/item', to: "items#update"
  delete '/dashboard/item', to: "items#destroy"

  resources :items, only: [:index, :show]
  resources :users, only: [:create, :update]
  resources :carts, only: [:create]

  namespace :admin do
    resources :users, only: [:index, :show, :update]
    resources :users, as: :merchants, only: [:index, :show, :update]
  end

  namespace :profile do
    resources :orders, only: [:index, :show, :create]
    get '/', to: "users#show"
    get '/edit', to: "users#edit"
  end

end
