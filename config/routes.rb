Rails.application.routes.draw do
  resources :posts
  devise_for :users
  root 'static#homepage'
end
