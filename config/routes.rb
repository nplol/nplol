Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments, only: [:new, :create]
  end

  resources :assets, only: [:new, :create, :destroy]

  post '/post_form', to: 'posts#form', as: 'post_form'

  root 'posts#index'

end
