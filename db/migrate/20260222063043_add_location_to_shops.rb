class AddLocationToShops < ActiveRecord::Migration[7.1]
  def change
    add_column :shops, :area, :string
    add_column :shops, :booth_number, :string
  end
end
