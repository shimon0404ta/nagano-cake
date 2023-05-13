Rails.application.routes.draw do
  
  root to: 'homes#top'
  get 'about' => 'homes#about'
  
  namespace :admin do
    resources :customers, only: [:show, :index, :edit, :update]
    resources :orders, only: [:show, :update, :index]
    resources :items
    resources :genres
  end
  
  scope module: 'public' do
    resources :items, only: [:show, :index]
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
