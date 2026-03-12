Rails.application.routes.draw do
  root "shops#index"
  
  # イベント管理
  resources :events, only: [:new, :create, :edit, :update, :destroy] do
    # ショップ管理（イベントに紐づく形に整理）
    resources :shops do
      collection do
        get :layout # /events/:event_id/shops/layout
      end
    end
    
    # ブース管理（追加・更新・削除）
    resources :booths, only: [:create, :update, :destroy]
  end

  # 下位互換用（必要であれば残しますが、上記イベント紐付けが推奨です）
  resources :shops, only: [:index, :show, :new, :create, :edit, :update, :destroy]
end