Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments
  end

  resources :assets, only: :new

  namespace 'dev' do
    resources :posts
    resources :comments
  end

  get 'dev', to: 'dev/posts#index'

  root 'posts#index'

end
