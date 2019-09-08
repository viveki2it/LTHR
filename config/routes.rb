Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root :to => "users#new"

  post 'users/create' => 'users#create'
  get 'refer-a-friend' => 'users#refer'
  get 'privacy-policy' => 'users#policy'
  
  resources :users, only: [:show]

  unless Rails.application.config.consider_all_requests_local
    get '*not_found', to: 'users#redirect', :format => false
  end
  mount Split::Dashboard, at: '/split'  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
