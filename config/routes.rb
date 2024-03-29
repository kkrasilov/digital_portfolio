Rails.application.routes.draw do
  devise_for :users
  root 'portfolios#index'

  get '/guests', to: redirect('/guests.html')

  resources :articles do 
    get :about, on: :collection
  end
end
