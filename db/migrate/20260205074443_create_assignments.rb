class CreateAssignments < ActiveRecord::Migration[7.1]
  def change
    create_table :assignments do |t|
      t.references :event, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true
      t.references :booth, null: false, foreign_key: true
      t.date :event_date, null: false # ここに null: false を追加
      t.boolean :is_sub_booth, default: false, null: false

      t.timestamps
    end
  end
end