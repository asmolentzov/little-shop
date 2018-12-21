Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/cart', to: "carts#show"
  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"
  get '/register', as: :registration, to: "users#new"
  delete '/logout', to: "sessions#destroy"

  get '/merchants', as: :merchants, to: "users#index"
  get '/dashboard', as: :dashboard, to: "users#show"
  get '/dashboard/items', to: "items#index"

  post '/deactivate', to: "users#enable"
  post '/activate', to: "users#enable"


  resources :items, only: [:index, :show]
  resources :users, only: [:create, :update]

  namespace :admin do
    resources :users, only: [:index, :show]
    resources :users, as: :merchants, only: [:index, :show]
  end

  namespace :profile do
    resources :orders, only: [:index]
    get '/', to: "users#show"
    get '/edit', to: "users#edit"
  end

end
