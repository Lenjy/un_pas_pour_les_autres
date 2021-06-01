Rails.application.routes.draw do
  get 'friend_requests/create'
  get 'friend_requests/new'
  get 'friend_requests/show'
  get 'steps/new'
  get 'steps/show'
  root to: 'pages#home'

  # , controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_for :users
  resources :users, only: [:index, :show] do
    collection do
      post 'search'
    end
    resources :friend_requests, only: [:create]do 
      member do 
        patch :accept 
        patch :decline
      end 
    end 
  end


  resources :campaigns
  resources :charity_events, only: [:show]
  resources :teams, only: [:show]
  resources :donation_payments, only: [:show, :create] do
    resources :payments, only: :new
  end
  get 'dashboard', to: 'pages#dashboard', as: 'dashboard'
  get 'donate', to: 'pages#donate', as: 'donate'
  get 'secret', to: 'pages#secret', as: 'secret'
  mount StripeEvent::Engine, at: '/stripe-webhooks'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
