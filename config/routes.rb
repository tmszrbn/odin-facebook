Rails.application.routes.draw do

  devise_scope :user do
    root to: 'devise/registrations#new'
  end 

  get 'users/index'
  get 'users/show'
  
  resources :comments, only: [:create, :destroy, :update]
  resources :friendship_requests, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts
  # devise_for :users
  # devise_for :users, controllers: {}
  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations', 
                                    omniauth_callbacks: 'users/omniauth_callbacks' }

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
