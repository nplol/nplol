Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments
    resources :assets, only: :new
  end

  namespace 'dev' do
    resources :posts
    resources :comments
  end

  get 'dev', to: 'dev/posts#index'

  root 'posts#index'

end
