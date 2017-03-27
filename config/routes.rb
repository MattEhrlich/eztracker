Rails.application.routes.draw do
 	
  devise_for :users
 	root 'staticpages#home'
  resources :users, only: [:show]
  resources :workouts, only: [:index]
  resources :exercises, only: []
  resources :sessions, only: [:update, :show, :create]
  
  get 'product', to: 'staticpages#product'
  get 'app', to: 'staticpages#app'
  get 'about', to: 'staticpages#about'
  get 'sales', to: 'staticpages#sales'

end
