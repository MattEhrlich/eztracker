Rails.application.routes.draw do
 	
  devise_for :users
 	root 'staticpages#home'
  resources :workouts, only: [:index]
  resources :exercises, only: []
  resources :trainings, only: [:update, :show, :create]
  resources :dashboards, only: [:show]
  resources :userprofiles
  # resources :ibeacons, {format: :json}
  resources :ibeacons, only: [:index, :new, :create, :show]
  get 'product', to: 'staticpages#product'
  get 'app', to: 'staticpages#app'
  get 'about', to: 'staticpages#about'
  get 'menu', to: 'staticpages#menu'
  get 'performance', to: 'staticpages#performance'
  get 'analytics', to: 'staticpages#analytics'
  get 'dashboard', to: 'staticpages#dashboard'
  get 'compare-workouts', to: 'staticpages#compare_workouts'
end
