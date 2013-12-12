Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments, only: [:new, :create]
  end

  resources :assets, only: [:new, :create]

  get '/meme/new', to: 'posts#meme', as: 'new_meme'

  #
  #namespace 'dev' do
  #  resources :posts
  #  resources :comments
  #end
  #
  #get 'dev', to: 'dev/posts#index'

  root 'posts#index'

end
