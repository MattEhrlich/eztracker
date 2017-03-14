Rails.application.routes.draw do
 	
  devise_for :users
 	root 'staticpages#home'
  resources :users, only: [:show]
  resources :workouts, only: [:index]
  resources :exercises, only: []
  resources :sessions, only: [:update, :show, :create]
end
