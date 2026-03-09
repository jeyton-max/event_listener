class AddFireAndJointFieldsToShops < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :has_fire, :boolean
    add_column :shops, :fire_type, :string
    add_column :shops, :has_extinguisher, :boolean
    add_column :shops, :is_joint_venture, :boolean
    add_column :shops, :joint_partner_name, :string
  end
end
