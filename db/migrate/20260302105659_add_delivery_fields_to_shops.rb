class AddDeliveryFieldsToShops < ActiveRecord::Migration[7.1]
  def change
    # 配送希望の有無：必須（デフォルトは「無」）
    # これにより「未回答」という曖昧な状態を排除します
    add_column :shops, :delivery_needed, :boolean, null: false, default: false
    
    # 配送予定口数：任意（デフォルト0）
    add_column :shops, :delivery_count, :integer, default: 0
    
    # 送り状番号：任意
    add_column :shops, :delivery_tracking_number, :string
    
    # 配送ステータス：必須（デフォルトは「0:未着」）
    # プログラム側で常に値が存在することを前提にロジックを組めるようにします
    add_column :shops, :delivery_status, :integer, null: false, default: 0
  end
end