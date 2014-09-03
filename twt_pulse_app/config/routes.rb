Rails.application.routes.draw do
  get 'home/show'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :tweets, only: [:new, :create]
  get '/tweets/search', to: 'tweets#search'
  get '/tweets/search_results', to: 'tweets#results'
  resources :sessions, only: [:create, :destroy]
  resource :home, only: [:show]

  root to: 'home#show'
end
