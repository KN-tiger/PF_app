Rails.application.routes.draw do

  namespace :public do
    get 'admin/index'
  end
  scope module: :public do
    root to: "homes#top"
    get '/about', to: 'homes#about', as: 'about'
    resources :items, only: [:index,:show]
    get '/users/my_page', to: 'users#show', as: 'my_page'
    delete 'cart_items/destroy_all', to: 'cart_items#destroy_all', as: 'cart_items_destroy_all'
    resources :cart_items, except: [:show,:new,:edit]
    post 'orders/confirm', to: 'orders#confirm', as: 'orders_confirm'
    get 'orders/complete', to: 'orders#complete', as: 'orders_complete'
    resources :orders, except: [:edit,:update,:destroy]
    resources :genres, only: [:show]
    resources :tags, only: [:show]
    resources :admins, only: [:index,:show]
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
  }

# 管理者用

  namespace :admin do
    root to: "homes#top"
    resources :items, except: [:destroy]
    resources :genres, except: [:new,:show,:destroy]
    resources :tags, except: [:new,:show,:destroy]
    get 'users/:id/order_history', to: 'users#order_history', as: 'users_order_history'
    patch 'users/:id/deactivate', to: 'users#deactivate', as: 'users_deactivate'
    resources :users, except: [:new,:create,:destroy]
    patch 'admins/:id/deactivate', to: 'admins#deactivate', as: 'admins_deactivate'
    resources :admins, except: [:new,:create,:destroy]
    resources :orders, only: [:index,:show,:update] do
      resources :order_items, only: [:update]
    end
    resources :messages, only: [:create]
    resources :rooms, only: [:create,:show]
    post 'admins/guest_sign_in', to: 'admins/sessions#guest_sign_in'
  end

  devise_for :admin,skip: [:passwords], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

end