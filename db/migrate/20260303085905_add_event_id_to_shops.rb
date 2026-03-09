class AddEventIdToShops < ActiveRecord::Migration[7.1]
  def change
    # 現場の解像度を維持するため、イベントなしのショップを許容しない制約を追加
    add_reference :shops, :event, null: false, foreign_key: true
  end
end