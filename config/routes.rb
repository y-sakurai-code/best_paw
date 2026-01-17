Rails.application.routes.draw do

  get "search" => "searches#search"
  get 'users/mypage'
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  resources :users, only: [:index, :show, :edit, :update, :destroy]
  resources :reviews, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
    resources :review_comments, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
end
