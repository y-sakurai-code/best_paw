Rails.application.routes.draw do

  namespace :admin do
    get 'reviews_managements/index'
    get 'reviews_managements/show'
  end
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
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:show, :destroy]
    resources :reviews_managements, only: [:index, :show, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
