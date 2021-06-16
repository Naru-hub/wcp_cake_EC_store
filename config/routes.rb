Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #管理者ログイン
  devise_for :admins, controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
}
  
  #管理者側
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :order_details, only: [:update]
    resources :orders, only: [:show, :update]
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    get root to: 'homes#top'
  end
  
  
  #会員ログイン
  devise_for :customers, controllers: {
  sessions:      'customers/sessions',
  passwords:     'customers/passwords',
  registrations: 'customers/registrations'
}

  
  #会員側
  scope module: :customers do
    resources :customers, only: [:show, :edit, :update]
    post 'customers/confirm' => 'customers#confirm'
    patch 'customers/out' => 'customers#out'
    resources :products, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :create]
    delete 'cart_items/all_destroy' => 'cart_items#all_destroy'
    delete 'cart_items/:id' => 'cart_items#destroy', as: 'destroy_cart'
    resources :orders, only: [:new, :create, :index, :show]
    get 'orders/thanx' => 'orders#thanx'
    post 'orders/confirm' => 'orders#confirm'
    resources :addresses, only: [:index, :create, :destroy, :edit, :update]
    get root to: "homes#top"
    get 'about' => 'homes#about'
  end
end