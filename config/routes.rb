Rails.application.routes.draw do

  root 'top#default'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  resources :users, only: [:show, :new, :create]
end
