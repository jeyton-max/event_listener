Rails.application.routes.draw do
  root "shops#index"
  
  resources :events, only: [:new, :create, :edit, :update, :destroy] do
    resources :shops do
      collection do
        get :layout
        # 💡 自由配置枠（ブース）を削除・解除するためのルーティングを追加
        delete :remove_free_booth
      end

      # 特定のショップに対してブース番号を更新する設定
      member do
        patch :update_booth
      end
    end
    
    # イベントに紐付くブース自体の管理（もしモデルとして存在する場合）
    resources :booths, only: [:create, :update, :destroy]
  end

  # 下位互換用、およびイベントに紐付かないショップ操作用
  resources :shops
end