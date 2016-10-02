Rails.application.routes.draw do
  resources :audit_logs, except: [:new, :edit, :destroy]
  
  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users
    
    root to: "users#index"
  end

  resources :posts do
  # allows for custom controller method
    member do
      get :approve
    end
  end
  
  devise_for :users, skip: :registrations
  root 'static#homepage'
end
