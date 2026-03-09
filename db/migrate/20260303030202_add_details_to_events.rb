class AddDetailsToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :areas, :text
    add_column :events, :parking_info, :text
    add_column :events, :parking_map_url, :string
  end
end
