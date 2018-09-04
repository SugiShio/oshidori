Rails.application.routes.draw do

  root 'top#default'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  resource :profile, only: [:show, :edit, :update], controller: 'users'
  resource :create_account, only: [:new, :create, :show], controller: 'activation_tokens'

end
