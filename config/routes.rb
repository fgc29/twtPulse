Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]

  # resources :tweets, only: [:new, :create, :index]
  resources :tweets, only: [:index]
  get '/tweets/search', to: 'tweets#search'
  get '/tweets/search_results', to: 'tweets#results'
  get '/tweets/start', to: 'tweets#start'
  root to: 'tweets#home'
end
