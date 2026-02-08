Rails.application.routes.draw do

  scope module: :public do
    devise_for :users
    get 'tagsearches/search', to: 'tagsearches#search'
    get "search" => "searches#search"
    get 'users/mypage'
    root to: 'homes#top'
    get 'homes/about', to: 'homes#about', as: :about
    resources :users, only: [:index, :show, :edit, :update, :destroy]
    resources :reviews, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resource :favorite_reviews, only: [:create, :destroy]
      resources :review_comments, only: [:create, :destroy]
    end
      resources :review_comments do
        resource :favorite_comments, only: [:create, :destroy]
      end
  end

  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    root to: 'dashboards#index'
    resources :users, only: [:show, :destroy]
    resources :users_managements, only: [:index, :show, :destroy]
    resources :items
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :reviews_managements, only: [:index, :show, :destroy] do
      member do
        delete :destroy_comment
      end
    end
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
