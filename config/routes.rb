Rails.application.routes.draw do
  get 'admin' => 'admin#index'
  namespace :users do
    get :orders
    get :line_items
  end
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end

  resources :support_requests, only: [ :index, :update ]

  resources :users
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products do
    get :who_bought, on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
