Rails.application.routes.draw do
  root 'store#index', as: 'store_index'

  constraints(-> (req) { req.env["HTTP_USER_AGENT"] !~ /Firefox/ }) do
    get 'catagories/catagory_with_subcatagory', to: 'catagories#catagory_with_subcatagory'
    get 'my-orders', to: 'users#orders'
    get 'my-items', to: 'users#line_items'
    get 'catagories/:id/books', to: 'store#index', constraints: { id: /\D+/ }
    namespace :admin do
      get :index
      get :reports
      get :catagories
    end
    namespace :users do
      get :orders
      get :line_items
    end
    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      get 'logout' => :destroy
    end
    resources :catagories do
      resources :products, path: :books
    end
    resources :support_requests, only: [ :index, :update ]
    resources :users
    resources :orders
    resources :line_items
    resources :carts
    resources :products, path: :books do
      get :who_bought, on: :member
    end
  end
end