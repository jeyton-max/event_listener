class CreateOperationSettings < ActiveRecord::Migration[7.1]
  def change
    create_table :operation_settings do |t|
      t.references :event, null: false, foreign_key: true
      t.string :area_name, null: false
      t.integer :admin_power_load, default: 0, null: false
      t.integer :max_power_limit, default: 20, null: false
      t.integer :admin_desk_count, default: 0, null: false
      t.integer :admin_round_table_count, default: 0, null: false
      t.integer :admin_chair_count, default: 0, null: false

      t.timestamps
    end
  end
end