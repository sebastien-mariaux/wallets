Rails.application.routes.draw do
  root 'dashboard#home'

  resources :wallets
  resources :coins
end
