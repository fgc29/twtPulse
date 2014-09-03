Rails.application.routes.draw do
  get 'tweets/show'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  get 'signout', to: 'sessions#destroy', as: 'signout'
  resources :sessions, only: [:create, :destroy]

  resources :tweets, only: [:new, :create, :index]
  get '/tweets/search', to: 'tweets#search'
  get '/tweets/search_results', to: 'tweets#results'

  root to: 'tweets#index'
end
