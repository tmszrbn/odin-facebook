Rails.application.routes.draw do

  get 'users/index'
  get 'users/show'
  # devise_scope :user do
  #   root to: 'devise/registrations#new'
  # end

  get 'comments/new'
  get 'comments/edit'
  
  resources :posts
  
  resources :friendship_requests, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]

  devise_for :users
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
