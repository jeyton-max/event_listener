# 既存データの削除
puts "Cleaning database..."
Assignment.delete_all
OperationSetting.delete_all
Event.delete_all
Shop.delete_all
Booth.delete_all

puts "Creating seed data..."

# 1. イベントの作成
event = Event.create!(
  name: "2026年 春のハンドメイドマルシェ",
  total_inventory_desks: 100,
  total_inventory_chairs: 200
)

# 2. 運営設定の作成
OperationSetting.create!(event: event, area_name: "Aエリア", admin_power: 5, max_power: 50)

# 3. ショップの作成
shop_common = {
  receipt_name: "テスト代表者",
  shipping_name: "テスト配送先",
  tel: "090-0000-0000",
  zip_code: "123-4567",
  address: "東京都渋谷区1-1-1",
  region: "東京都",
  power_usage: 0
}

shop1 = Shop.create!(shop_common.merge(name: "キラキラ工房", power_usage: 10))
shop2 = Shop.create!(shop_common.merge(name: "もふもふ雑貨店"))

# 4. ブースの作成 (capacity を削除しました)
booth_a1 = Booth.create!(booth_code: "A-01", area_category: "Aエリア")
booth_b1 = Booth.create!(booth_code: "B-01", area_category: "Bエリア")

# 5. 配置データの作成
Assignment.create!(
  event: event, shop: shop1, booth: booth_a1,
  event_date: Date.today, # 今日の日付に設定
  is_sub_booth: false
)
Assignment.create!(
  event: event, shop: shop2, booth: booth_b1,
  event_date: Date.today,
  is_sub_booth: false
)

puts "Successfully created seed data!"