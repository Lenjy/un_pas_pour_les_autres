Rails.application.routes.draw do
  get 'steps/new'
  get 'steps/show'
  root to: 'pages#home'
  
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } do
    resources :friends, only: [:new, :create, :show]
  end
  resources :campaigns
  resources :charity_events, only: [:show]
  resources :teams, only: [:show]
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'donate', to: 'pages#donate', as: 'donate'
  get 'secret', to: 'pages#secret', as: 'secret'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
