Rails.application.routes.draw do
  get 'likes/new'
  get 'likes/create'
  get 'likes/destroy'
  resources :posts
  get 'friendships/index'
  get 'friendships/create'
  post 'friendships/update', to: 'friendships#update'
  get 'users/show'
  get 'users/index'
  devise_for :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
