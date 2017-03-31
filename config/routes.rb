Rails.application.routes.draw do
 	
  devise_for :users
 	root 'staticpages#home'
  resources :workouts, only: [:index]
  resources :exercises, only: []
  resources :trainings, only: [:update, :show, :create]
  resources :dashboards, only: [:show]
  get 'product', to: 'staticpages#product'
  get 'app', to: 'staticpages#app'
  get 'about', to: 'staticpages#about'
  get 'sales', to: 'staticpages#sales'

end
