Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments, only: [:new, :create]
  end

  # assets have to live as top-level resources in order to be
  # created before the posts themselves. A cron job is run
  # every once in a while to delete assets without posts.
  resources :assets, only: [:new, :create, :destroy]

  post '/post_form', to: 'posts#form', as: 'post_form'

  root 'posts#index'

  get 'header', to: 'sessions#header'
  get 'authorize', to: 'sessions#authorize', as: 'authorize'

  # Oatuh paths
  post '/auth/google_oauth2/callback/', to: 'sessions#create'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

end
