Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments, only: [:new, :create]
  end

  resources :assets, only: [:new, :create]

  #
  #namespace 'dev' do
  #  resources :posts
  #  resources :comments
  #end
  #
  #get 'dev', to: 'dev/posts#index'

  root 'posts#index'

end
