class AllowNullToDeliveryStatusInShops < ActiveRecord::Migration[7.0]
  def change
    # delivery_status カラムの NOT NULL 制約を解除します
    change_column_null :shops, :delivery_status, true
  end
end