class RemovePowerDetailsFromShops < ActiveRecord::Migration[7.1]
  def change
    remove_column :shops, :power_usage, :integer
    remove_column :shops, :power_purpose, :string
  end
end
