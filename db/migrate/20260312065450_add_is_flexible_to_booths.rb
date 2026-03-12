class AddIsFlexibleToBooths < ActiveRecord::Migration[7.0]
  def change
    # 自由配置フラグを追加（デフォルトは固定配置の false）
    add_column :booths, :is_flexible, :boolean, default: false, null: false

    # 既存の座標カラムにデフォルト値 0 を設定し、計算やJSでの扱いを楽にする
    change_column_default :booths, :pos_x, from: nil, to: 0
    change_column_default :booths, :pos_y, from: nil, to: 0
    
    # すでにレコードがある場合、座標が nil だと表示されない可能性があるため
    # 必要に応じて既存データを 0 で更新する処理を入れると安全です
    reversible do |dir|
      dir.up do
        execute "UPDATE booths SET pos_x = 0 WHERE pos_x IS NULL"
        execute "UPDATE booths SET pos_y = 0 WHERE pos_y IS NULL"
      end
    end
  end
end