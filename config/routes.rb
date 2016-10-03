Rails.application.routes.draw do
  resources :audit_logs, except: [:new, :edit, :destroy] do
    member do
      get :confirm
    end
  end
  
  namespace :admin do
    resources :users
    resources :posts
    resources :admin_users
    resources :employees
    
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
