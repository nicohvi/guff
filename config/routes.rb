Rails.application.routes.draw do
  resources :users, :events

  root 'events#index'

  # custom routes
  get '/hello', to: 'home#index', as: 'home'
  get '/auth/:provider/callback', to: 'sessions#create', as: 'auth'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
