Rails.application.routes.draw do
  resources :salaries
  resources :user_profiles
  resources :statuses
  resources :designations
  resources :roles
  devise_for :users
  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
