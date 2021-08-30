Rails.application.routes.draw do

  namespace :admin do
    get :index
    resources :reports
    resources :catagories do
      get :catagory_with_subcatagory, on: :collection
    end
  end
  
  get 'admin' => 'admin#index'
  resources :users do
    get :orders, on: :collection
    get :line_items, on: :collection
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
