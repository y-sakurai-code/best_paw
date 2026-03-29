Rails.application.routes.draw do

  root to: 'public/homes#top'

  scope module: :public do
    devise_for :users
      devise_scope :user do
        post 'users/guest_sign_in', to: 'guest_sessions#guest_sign_in', as: '/guest_sign_in'
      end
    get 'tagsearches/search', to: 'tagsearches#search'
    get "search" => "searches#search"
    get 'users/mypage'
    get 'homes/about', to: 'homes#about', as: :about
    resources :notifications, only: [:index, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      member do
        patch :withdraw
      end
    end
    resources :dogs do
      collection do
        get :memorial
      end
      member do
        patch :archive
      end
    end
    resources :reviews, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resource :favorite_reviews, only: [:create, :destroy]
      resources :review_comments, only: [:create, :destroy] do
        resource :favorite_comments, only: [:create, :destroy]
      end
    end
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'dashboards#index'
    resources :users_managements, only: [:index, :show, :destroy]do
      member do
        patch :soft_destroy
        patch :undiscard
        patch :withdraw
      end
    end
    resources :genres, only: [:new, :index, :create, :edit, :update, :destroy]
    resources :reviews_managements, only: [:index, :show, :destroy] do
      member do
        delete :destroy_comment
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
