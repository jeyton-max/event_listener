class AddPowerFieldsToShops < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :has_power, :boolean, default: false, null: false
    add_column :shops, :power_usage, :integer
    add_column :shops, :power_purpose, :string
  end
end