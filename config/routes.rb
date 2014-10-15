Nplol::Application.routes.draw do

  resources :posts do
    resources :likes, only: :create
    resources :comments, only: [:new, :create, :destroy]
  end

  resources :users, only: [:new, :create]

  root 'posts#index'

  # Oatuh paths
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'
  get '/authorize', to: 'sessions#authorize_user', as: 'authorize'
  
end
