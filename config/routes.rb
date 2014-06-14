Rails.application.routes.draw do
  resources :users, :events

  root to: 'events#index'

  get '/auth/:provider/callback', to: 'sessions#create', as: 'auth'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
