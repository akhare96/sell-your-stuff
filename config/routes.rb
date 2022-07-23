Rails.application.routes.draw do
  
  root 'application#homepage'

  resources :users, only: [:create, :show, :edit, :update] do
    resources :posts, only: [:show, :index, :new]
    resources :favorites, only: [:index]
  end

  resources :posts, except: [:destroy]

  resources :favorites, only: [:create, :destroy]
  
  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  delete 'images/:id/purge', to: 'posts#purge_image', as: 'delete_image'
  delete 'posts/:id', to: 'posts#destroy', as: 'delete_post'

  
end
