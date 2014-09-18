Nplol::Application.routes.draw do

  resources :posts do
    get 'like', to: 'posts#like', as: 'like'
    resources :comments, only: [:new, :create, :destroy]
  end

  root 'posts#index'

  get 'header', to: 'sessions#header'
  get 'authorize', to: 'sessions#authorize_nplol', as: 'authorize'

  # Oatuh paths
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

end
