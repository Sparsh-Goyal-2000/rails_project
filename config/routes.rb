Rails.application.routes.draw do
  get 'catagories/catagory_with_subcatagory', to: 'catagories#catagory_with_subcatagory'

  resources :catagories
  get 'admin' => 'admin#index'
  get 'users/orders', to: 'users#show_user_orders'
  get 'users/line_items', to: 'users#show_user_line_items'
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
