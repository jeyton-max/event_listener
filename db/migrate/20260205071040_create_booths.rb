class CreateBooths < ActiveRecord::Migration[7.1]
  def change
    create_table :booths do |t|
      t.string :booth_code, null: false
      t.string :area_category, null: false
      t.boolean :is_admin_only, default: false, null: false
      t.boolean :has_outlet, default: false, null: false # null: false を追加
      t.float :pos_x
      t.float :pos_y

      t.timestamps
    end
  end
end