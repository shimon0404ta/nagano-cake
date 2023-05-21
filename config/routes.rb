Rails.application.routes.draw do
  
  root to: 'homes#top'
  get 'about' => 'homes#about'
  
  namespace :admin do
    resources :customers,      only: [:show, :index, :edit, :update]
    resources :orders,         only: [:show, :update, :index]
    resources :order_details,  only: [:update]
    resources :items
    resources :genres
  end
  
  scope module: 'public' do
    get 'customers/my_page'         => "customers#show"
    get 'customers/edit'            => "customers#edit"
    patch 'customers'               => "customers#update"
    get 'customers/unsubscribe'     => "customers#unsubscribe"
    patch 'customers/withdraw'      => "customers#withdraw"
    delete 'cart_items'             => "cart_items#destroy_all", as: "cart_items_destroy_all"
    get 'orders/confirm'            => "orders#confirm"
    post 'orders/confirm'           => "orders#confirm"
    get 'orders/thanks'             => "orders#thanks"
    get 'customers/my_page'         => "customers#show"
    get 'customers/edit'            => "customers#edit"
    patch 'customers'               => "customers#update"
    get 'customers/unsubscribe'     => "customers#unsubscribe"
    patch 'customers/withdraw'      => "customers#withdraw"
    
    resources :genres,               only: [:show]
    resources :items,                only: [:show, :index]
    resources :cart_items,           only: [:index, :update, :create, :destroy]
    resources :orders,               only: [:new, :show, :index, :create]
    resources :shipping_addresses,   only: [:index, :edit, :create, :update, :destroy]
  end
  
  # 顧客用
  # URL/customers/sign_in...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL/admin/sign_in...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
