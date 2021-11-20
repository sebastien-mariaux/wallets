Rails.application.routes.draw do
  root 'dashboard#home'

  resources :wallets do
    get :total, on: :member
  end
  resources :coins do
    get :total, on: :member
  end

  resources :coin_wallets, only: [] do
    get :quantity, on: :collection
    get :total, on: :collection
    post :create_or_update, on: :collection
  end

  resources :api, only: [] do
    get :list, on: :collection
  end

  resources :gecko_coins, only: [] do
    get :search, on: :collection
  end
end
