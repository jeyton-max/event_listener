Rails.application.routes.draw do
  root "shops#index"
  
  resources :events, only: [:new, :create, :edit, :update, :destroy] do
    resources :shops do
      collection do
        get :layout
      end
      # 💡 ここを追加！特定のショップ(member)に対してブース番号を更新する設定
      member do
        patch :update_booth
      end
    end
    
    resources :booths, only: [:create, :update, :destroy]
  end

  resources :shops # 下位互換用
end