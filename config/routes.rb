Rails.application.routes.draw do
  root 'top#default'
  resources :users, only: [:show]
end
