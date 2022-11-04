# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'dashboard#home'

  resource :dashboard, controller: :dashboard, only: [] do
    get :chart_data
    get :summary
  end

  resource :profile, only: %i[edit update]

  resources :trades, only: %i[create]

  resources :wallets do
    get :total, on: :member
  end

  resources :coins do
    get :total, on: :member
    get :reference_price, on: :member
    get :market_value, on: :member
    get :variation_from_reference, on: :member

    resources :trades, only: %i[index new create destroy]
  end

  resources :coin_wallets, only: [] do
    get :quantity, on: :collection
    get :total, on: :collection
    post :create_or_update, on: :collection
  end

  resources :api, only: [] do
    get :list, on: :collection
    get :prices, on: :collection
  end

  resources :gecko_coins, only: [] do
    get :search, on: :collection
  end

  resource :config, controller: :config

  resources :app_processes, only: :show

  resources :snapshots, only: %i[index] do
    get :request_snap, on: :collection
  end

  resource :backup, only: [] do
    get :import, on: :collection
    get :export, on: :collection
  end
end
