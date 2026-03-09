Rails.application.routes.draw do
  root "shops#index"
  
  # イベント管理用
  resources :events, only: [:new, :create, :edit, :update, :destroy]
  
  # ショップ管理用
  get 'shops/layout', to: 'shops#layout', as: 'layout_shops'
  resources :shops
end