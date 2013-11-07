Nplol::Application.routes.draw do

  resources :posts do
  	resources :comments
  end

  get 'dev', to: 'posts#dev'



  root 'posts#index'

end
