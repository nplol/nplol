Nplol::Application.routes.draw do

  resources :posts do
    get 'original_image', to: 'posts#original_image'
    resources :comments, only: [:new, :create, :destroy]
  end

  # assets have to live as top-level resources in order to be
  # created before the posts themselves. A cron job is run
  # every once in a while to delete assets without posts.
  resources :assets, only: [:new, :create, :destroy]

  root 'posts#index'

  get 'header', to: 'sessions#header'
  get 'authorize', to: 'sessions#authorize_nplol', as: 'authorize'

  # Oatuh paths
  # post '/auth/google_oauth2/callback/', to: 'sessions#create'
  # get '/auth/twitter/callback', to: 'sessions#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

end
