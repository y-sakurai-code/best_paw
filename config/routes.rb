Rails.application.routes.draw do
  get 'reviews/new'
  get 'reviews/index'
  get 'reviews/show'
  get 'reviews/edit'
  devise_for :users
  root to: 'homes#top'
  get 'homes/about', to: 'homes#about', as: :about
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
