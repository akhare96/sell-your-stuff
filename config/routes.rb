Rails.application.routes.draw do
  
  root 'application#homepage'

  resources :users, only: [:new, :create, :show, :edit, :update] do
    resources :posts, only: [:show, :index]
    resources :favorites, only: [:index]
  end

  resources :posts

  get '/signup', to: 'users#new', as: 'signup'
  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create'
  get '/auth/github/callback', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
end
