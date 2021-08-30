Rails.application.routes.draw do

  root 'store#index', as: 'store_index'

  constraints(-> (req) { req.env["HTTP_USER_AGENT"] !~ /Firefox/ }) do
    get 'admin' => 'admin#index'
    get 'my-orders', to: 'users#orders'
    get 'my-items', to: 'users#line_items'
    namespace :admin do
      get :index
      resources :reports
      resources :catagories do
        get :catagory_with_subcatagory, on: :collection
      end
    end
    resources :users do
      get :orders, on: :collection
      get :line_items, on: :collection
    end
    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      get 'logout' => :destroy
    end
    resources :catagories do
      get 'books', to: 'store#index', constraints: { catagory_id: /[\D]+.*/ }
      get :products, to: 'products#index', path: :books
    end
    resources :support_requests, only: [ :index, :update ]
    resources :orders
    resources :line_items
    resources :carts
    resources :products, path: :books do
      get :who_bought, on: :member
    end
  end
end