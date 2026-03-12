# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2026_03_12_091440) do
  create_table "active_storage_attachments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "assignments", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "shop_id", null: false
    t.bigint "booth_id", null: false
    t.date "event_date", null: false
    t.boolean "is_sub_booth", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booth_id"], name: "index_assignments_on_booth_id"
    t.index ["event_id"], name: "index_assignments_on_event_id"
    t.index ["shop_id"], name: "index_assignments_on_shop_id"
  end

  create_table "booths", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "booth_code", null: false
    t.string "area_category", null: false
    t.boolean "is_admin_only", default: false, null: false
    t.boolean "has_outlet", default: false, null: false
    t.float "pos_x", default: 0.0
    t.float "pos_y", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_flexible", default: false, null: false
    t.bigint "event_id", null: false
    t.index ["event_id"], name: "index_booths_on_event_id"
  end

  create_table "daily_details", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "shop_id", null: false
    t.date "event_date", null: false
    t.integer "desk_count", default: 0, null: false
    t.integer "round_table_count", default: 0, null: false
    t.integer "chair_count", default: 0, null: false
    t.boolean "is_electric_needed", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "power_usage"
    t.string "power_purpose"
    t.index ["shop_id"], name: "index_daily_details_on_shop_id"
  end

  create_table "events", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "location", null: false
    t.string "address"
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "total_inventory_desks", default: 0, null: false
    t.integer "total_inventory_chairs", default: 0, null: false
    t.integer "total_inventory_round_tables", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "areas"
    t.text "parking_info"
    t.string "parking_map_url"
  end

  create_table "operation_settings", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.string "area_name", null: false
    t.integer "admin_power_load", default: 0, null: false
    t.integer "max_power_limit", default: 20, null: false
    t.integer "admin_desk_count", default: 0, null: false
    t.integer "admin_round_table_count", default: 0, null: false
    t.integer "admin_chair_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_operation_settings_on_event_id"
  end

  create_table "shops", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "receipt_name"
    t.string "shipping_name"
    t.string "tel"
    t.string "zip_code"
    t.string "address"
    t.string "region"
    t.boolean "is_first_time", default: false, null: false
    t.string "category", default: "未設定", null: false
    t.string "attendance_type"
    t.boolean "is_sns_posted", default: false, null: false
    t.text "pr_text"
    t.boolean "is_both_days", default: true, null: false
    t.integer "booth_count", default: 1, null: false
    t.string "instagram_url", default: "https://", null: false
    t.text "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_fire", default: false, null: false
    t.string "fire_type"
    t.boolean "has_extinguisher", default: false, null: false
    t.boolean "is_joint_venture", default: false, null: false
    t.string "joint_partner_name"
    t.string "area"
    t.string "booth_number"
    t.boolean "delivery_needed", default: false, null: false
    t.integer "delivery_count", default: 0
    t.string "delivery_tracking_number"
    t.integer "delivery_status", default: 0
    t.bigint "event_id", null: false
    t.boolean "has_power", default: false, null: false
    t.index ["event_id"], name: "index_shops_on_event_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignments", "booths"
  add_foreign_key "assignments", "events"
  add_foreign_key "assignments", "shops"
  add_foreign_key "booths", "events"
  add_foreign_key "daily_details", "shops"
  add_foreign_key "operation_settings", "events"
  add_foreign_key "shops", "events"
end
