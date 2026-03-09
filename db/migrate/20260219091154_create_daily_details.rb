class CreateDailyDetails < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_details do |t|
      t.references :shop, null: false, foreign_key: true
      t.date :event_date, null: false
      t.integer :desk_count, default: 0, null: false
      t.integer :round_table_count, default: 0, null: false
      t.integer :chair_count, default: 0, null: false
      t.boolean :is_electric_needed, default: false, null: false

      t.timestamps
    end
  end
end