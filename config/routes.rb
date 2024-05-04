Rails.application.routes.draw do
  devise_for :users
  root 'portfolios#index'

  get '/guests', to: redirect('/guests.html')

  resources :articles do 
    get :about, on: :collection
  end

  resources :users, only: %i[edit update] do
    get :profile, on: :collection
  end

  resources :portfolios, only: %i[index show]
  resources :awards, only: %i[new edit create update destroy]
end
