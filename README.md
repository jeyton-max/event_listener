# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## テーブル設計

### shops テーブル（出店者情報）
| Column | Type | Options | Description |
| --- | --- | --- | --- |
| event_id | bigint | null: false, foreign_key: true | 関連イベントID（どの開催回に属するか） |
| name | string | null: false | ショップ名 |
| receipt_name | string | | 領収書用宛名（屋号等） |
| shipping_name | string | | 配送用宛名（個人名） |
| tel | string | | 緊急連絡先 |
| zip_code | string | | 郵便番号 |
| address | string | | 住所 |
| region | string | | 拠点地域（無料ルール判定用） |
| category | string | null: false | カテゴリ（雑貨、スイーツ等） |
| is_joint_venture | boolean | null: false, default: false | 共同出店フラグ（重なり配置判定用） |
| joint_partner_name | string | | 共同相手の店舗名（紐付け用キー） |
| attendance_type | string | | 出店枠（通常、共同、無料等） |
| is_first_time | boolean | null: false, default: false | 初出店フラグ |
| is_both_days | boolean | null: false, default: true | 両日出店フラグ（現場の多数派に合わせる） |
| booth_count | integer | null: false, default: 1 | 希望ブース数（出店料の乗数） |
| has_fire | boolean | null: false, default: false | 火器使用フラグ（配置図🔥マーク表示用） |
| fire_type | string | | 使用火器の詳細（ガス、炭火、IH等） |
| has_extinguisher | boolean | null: false, default: false | 消火器持込確認（安全管理用） |
| is_sns_posted | boolean | default: false | SNS投稿済チェック |
| has_power | boolean | null: false, default: false | 電力使用フラグ（配置図⚡マーク表示用） |
| pr_text | text | | AI生成PR文 |
| instagram_url | string | null: false | アカウントURL |
| image_url | text | | 配置用画像URL（AIが後に取得） |
| area | string | | 出店エリア（プロムナード、HIROPPA等） |
| booth_number | string | | ブース番号（A-1、物販-1等） |
| delivery_needed | boolean | null: false, default: false | 事前荷物配送の有無（希望者のみ） |
| delivery_count | integer | default: 0 | 配送予定口数（員数チェック用） |
| delivery_tracking_number | string | | 送り状伝票番号（ヤマト運輸等） |
| delivery_status | integer | default: 0 | 配送ステータス（0:未着, 1:受取済, 2:配置済, 3:発送待ち, 4:完了） |

※ カテゴリごとの単価・グループ分けは、モデル内の `CATEGORY_SETTINGS` 定数で管理する。

### daily_details テーブル（日別変動・備品）
| Column | Type | Options | Description |
| --- | --- | --- | --- |
| shop_id | bigint | null: false, foreign_key: true | ショップID |
| event_date | date | null: false | 開催日 |
| desk_count | integer | null: false, default: 0 | 長机数（1日500円/台） |
| round_table_count | integer | null: false, default: 0 | 丸テーブル数（1日500円/台） |
| chair_count | integer | null: false, default: 0 | 椅子数（無料） |
| is_electric_needed | boolean | null: false, default: false | 電力使用の有無（1日500円） |
| power_usage | integer | | 使用アンペア数 |
| power_purpose | string | | 電力使用用途 |

### booths テーブル（会場設備）
| Column | Type | Options | Description |
| --- | --- | --- | --- |
| booth_code | string | null: false | ブース番号（A-1等） |
| area_category | string | null: false | エリア名 |
| is_admin_only | boolean | null: false, default: false | 運営専用フラグ |
| has_outlet | boolean | null: false, default: false | コンセント有無 |
| pos_x | float | | 配置図内の横座標 |
| pos_y | float | | 配置図内の縦座標 |

### events テーブル（イベント全体管理）
| Column | Type | Options | Description |
| --- | --- | --- | --- |
| name | string | null: false | イベント名（vol.No） |
| location | string | null: false | 開催会場名 |
| address | string | | 会場住所 |
| start_date | date | null: false | 開催開始日 |
| end_date | date | null: false | 開催終了日 |
| areas | text | | 会場エリア設定（カンマ区切り等） |
| parking_info | text | | 駐車場情報（予約・台数・運用メモ等） |
| parking_map_url | string | | 駐車場Google Map等のURL |
| total_inventory_desks | integer | null: false, default: 0 | 会場全体の長机総在庫数 |
| total_inventory_chairs | integer | null: false, default: 0 | 会場全体の椅子総在庫数 |
| total_inventory_round_tables | integer | null: false, default: 0 | 会場全体の丸テーブル総在庫数 |
| (icon_image) | (Attached) | | [ActiveStorage] イベントメイン画像 |

### assignments テーブル（配置中間データ）
| Column | Type | Options | Description |
| --- | --- | --- | --- |
| event_id | bigint | null: false, foreign_key: true | イベントID |
| shop_id | bigint | null: false, foreign_key: true | ショップID |
| booth_id | bigint | null: false, foreign_key: true | ブースID |
| event_date | date | null: false | 開催日 |
| is_sub_booth | boolean | null: false, default: false | 2ブース目判定 |

### operation_settings テーブル（運営設定）
| Column | Type | Options | Description |
| --- | --- | --- | --- |
| event_id | bigint | null: false, foreign_key: true | イベントID |
| area_name | string | null: false | 対象エリア名 |
| admin_power_load | integer | null: false, default: 0 | 運営用電力 |
| max_power_limit | integer | null: false, default: 20 | エリア電力上限 |
| admin_desk_count | integer | null: false, default: 0 | 運営用長机確保数 |
| admin_round_table_count | integer | null: false, default: 0 | 運営用丸テーブル確保数 |
| admin_chair_count | integer | null: false, default: 0 | 運営用椅子確保数 |
