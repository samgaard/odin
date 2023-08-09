Rails.application.routes.draw do
  get 'likes/new'
  get 'likes/create'
  get 'likes/destroy'
  resources :posts do
    resources :comments, only: [:create]
  end
  resources :comments
  get 'friendships/index'
  get 'friendships/create'
  post 'friendships/update', to: 'friendships#update'
  devise_for :users
  resources :users, only: %i[index show]
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
end
