class ChangeColumnsDefaultToShops < ActiveRecord::Migration[7.1]
  def change
    Shop.reset_column_information
    # 既存のNULLをfalse(0)に置き換える
    Shop.where(has_fire: nil).update_all(has_fire: false)
    Shop.where(has_extinguisher: nil).update_all(has_extinguisher: false)
    Shop.where(is_joint_venture: nil).update_all(is_joint_venture: false)

    # README通り、null: false と default: false を設定する
    change_column_null :shops, :has_fire, false
    change_column_default :shops, :has_fire, from: nil, to: false

    change_column_null :shops, :has_extinguisher, false
    change_column_default :shops, :has_extinguisher, from: nil, to: false

    change_column_null :shops, :is_joint_venture, false
    change_column_default :shops, :is_joint_venture, from: nil, to: false
  end
end