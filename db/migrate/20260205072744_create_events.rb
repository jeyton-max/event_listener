class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :address
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.integer :total_inventory_desks, default: 0, null: false
      t.integer :total_inventory_chairs, default: 0, null: false
      t.integer :total_inventory_round_tables, default: 0, null: false

      t.timestamps
    end
  end
end