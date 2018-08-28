Rails.application.routes.draw do

  root 'top#default'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  delete '/signout', to: 'sessions#destroy'
  resource :user, only: [:show, :new, :create, :edit, :update]
end
