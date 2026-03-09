class ChangeColumnsDefaultToShops < ActiveRecord::Migration[7.1]
  # 👇 マイグレーション専用の身代わりクラス。これで Enum チェックを回避します
  class MigrationShop < ActiveRecord::Base
    self.table_name = :shops
  end

  def change
    # 本物の Shop モデルではなく、MigrationShop を使って更新します
    MigrationShop.where(has_fire: nil).update_all(has_fire: false)
    MigrationShop.where(has_extinguisher: nil).update_all(has_extinguisher: false)
    MigrationShop.where(is_joint_venture: nil).update_all(is_joint_venture: false)

    change_column_null :shops, :has_fire, false
    change_column_default :shops, :has_fire, from: nil, to: false

    change_column_null :shops, :has_extinguisher, false
    change_column_default :shops, :has_extinguisher, from: nil, to: false

    change_column_null :shops, :is_joint_venture, false
    change_column_default :shops, :is_joint_venture, from: nil, to: false
  end
end