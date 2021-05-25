Rails.application.routes.draw do
  get 'steps/new'
  get 'steps/show'
  root to: 'pages#home'
  devise_for :users do
    resources :friends, only: [:new, :create, :show]
    resources :steps, only: [:new, :create, :show]
  end
  resources :campaign
  resources :charity_events, only: [:show]
  resources :teams, only: [:show]
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'donate', to: 'pages#donate', as: 'donate'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
