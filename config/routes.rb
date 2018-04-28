Rails.application.routes.draw do
  get 'comments/new'
  get 'comments/edit'

  get 'posts/index'
  get 'posts/edit'
  get 'posts/new'
  get 'posts/show'

  devise_for :users
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions'
  # }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
