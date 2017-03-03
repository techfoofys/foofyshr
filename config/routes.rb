Rails.application.routes.draw do
  resources :instalments  do
    collection do
      get 'get_instalments'
    end
  end

  resources :documents
  resources :events
  resources :projects
  resources :salary_transactions
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :salaries
  resources :user_profiles
  resources :statuses
  resources :designations
  resources :roles
  devise_for :users
  root to: 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :hr do
    collection do
      get 'users'
      get 'get_user_profile'
      get 'invite'
    end
  end

  resources :finance do
    collection do
      get 'salaries'
      get 'check_probation'
      get 'update_probation'
      get 'get_current_salary'
      get 'pay_salary'
    end
  end


  get 'welcome/public/:id', to: 'welcome#public_profile', as: 'public'
  get 'welcome/public_project/:id', to: 'welcome#public_project', as: 'public_project'




end
