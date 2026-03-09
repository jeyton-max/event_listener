class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.string :name, null: false
      t.string :receipt_name
      t.string :shipping_name  # 必須を外す（任意にする）
      t.string :tel            # 必須を外す（任意にする）
      t.string :zip_code
      t.string :address        # 必須を外す（任意にする）
      t.string :region
      t.boolean :is_first_time, default: false, null: false
      
      # 新しい設計のカラム
      t.string :category, null: false, default: '未設定'
      t.string :attendance_type
      t.boolean :is_sns_posted, default: false, null: false
      t.text :pr_text
      
      t.boolean :is_both_days, default: true, null: false
      t.integer :booth_count, default: 1, null: false
      t.string :instagram_url, null: false, default: 'https://'
      t.text :image_url

      t.timestamps
    end
  end
end