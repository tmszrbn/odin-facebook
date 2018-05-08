Rails.application.routes.draw do

  root to: 'posts#index'
  
  resources :comments, only: [:create, :destroy, :update]
  resources :friendship_requests, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts
  resources :users, only: [:index, :show]
  get 'user/edit', to: 'users#edit'
  get 'user/update', to: 'users#update'
  # devise_for :users
  # devise_for :users, controllers: {}
  devise_for :users, 
             controllers: { sessions: 'users/sessions',
                            registrations: 'users/registrations', 
                            omniauth_callbacks: 'users/omniauth_callbacks' },
             path: 'account'
                    

  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
