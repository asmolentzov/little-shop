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

  # post '/dashboard/items', to: "items#create"

  # patch '/dashboard/items', to: "items#update"

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
  
  namespace :dashboard do
    resources :items, only: [:index, :edit, :update, :new, :create, :destroy]
    get '/', to: "users#show"
  end
  
  # get '/dashboard', as: :dashboard, to: "users#show"
  # get '/dashboard/items', to: "items#index"
  get '/dashboard/orders/:id', as: :dashboard_orders, to: "orders#show"
  # put '/dashboard/item', to: "items#update"
  # get '/dashboard/items/new', to: "items#new"
  # get '/dashboard/items/:id/edit', as: :dashboard_items_edit, to: "items#edit"
  # delete '/dashboard/item', to: "items#destroy"

end
