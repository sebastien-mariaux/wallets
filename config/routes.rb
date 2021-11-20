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
end
