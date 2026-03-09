class Shop < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_one_attached :layout_image

  belongs_to :event
  
  has_many :daily_details, dependent: :destroy
  accepts_nested_attributes_for :daily_details, allow_destroy: true

  # 保存・バリデーション前の処理
  before_validation :sanitize_instagram_urls
  before_save :clean_image_url

  validates :name, presence: true

  # 配送ステータスの定義
  enum delivery_status: {
    unreceived: 0,   # 未着
    received: 1,     # 受取済
    placed: 2,       # 配置済
    pending_ship: 3, # 発送待ち
    completed: 4     # 完了
  }

  # 配送ステータスの日本語表示用定数
  DELIVERY_STATUS_NAMES = {
    'unreceived'   => '未着',
    'received'     => '受取済',
    'placed'       => '配置済',
    'pending_ship' => '発送待ち',
    'completed'    => '完了'
  }.freeze

  # 現在の配送ステータスを日本語で返すメソッド
  def delivery_status_name
    DELIVERY_STATUS_NAMES[delivery_status]
  end

  # カテゴリ設定（単価・グループ分け）
  CATEGORY_SETTINGS = {
    '物販'           => { price: 3000, group: '物販/飲食' },
    'スイーツ'       => { price: 3000, group: '物販/飲食' },
    'ペット（犬）'    => { price: 4000, group: '物販/飲食' },
    '飲食'           => { price: 5000, group: '物販/飲食' },
    'キッチンカー'    => { price: 6000, group: '物販/飲食' },
    'ワークショップ'  => { price: 2000, group: '体験' },
    '企業'           => { price: 10000, group: 'その他' },
    '無料'           => { price: 0,     group: 'その他' }
  }.freeze

  # 備品単価設定
  EQUIPMENT_PRICES = {
    desk: 500,
    round_table: 500,
    power: 500
  }.freeze

  # ブース料金合計（単価 × ブース数 × 日数）
  def total_booth_fee
    unit_price = CATEGORY_SETTINGS.dig(category, :price) || 0
    days = is_both_days ? 2 : 1
    (booth_count || 1) * unit_price * days
  end

  # 備品料金合計
  def total_equipment_fee
    total = 0
    daily_details.each do |detail|
      total += (detail.desk_count || 0) * EQUIPMENT_PRICES[:desk]
      total += (detail.round_table_count || 0) * EQUIPMENT_PRICES[:round_table]
      total += EQUIPMENT_PRICES[:power] if detail.is_electric_needed
    end
    total
  end

  # 総計
  def grand_total
    total_booth_fee + total_equipment_fee
  end

  private

  # URL入力欄の自動掃除（ゴミデータを防ぐ）
  def sanitize_instagram_urls
    # 出店者のURL
    self.instagram_url = nil if instagram_url.blank? || instagram_url == "https://"
    
    # 共同相手の入力欄（joint_partner_name）
    self.joint_partner_name = nil if joint_partner_name.blank? || joint_partner_name == "https://"
  end

  # 画像URL（Instagramの埋め込みタグ用など）の掃除
  def clean_image_url
    if image_url.present?
      self.image_url = image_url.gsub('&amp;', '&').strip.gsub(/\A["']|["']\z/, '')
    end
  end
end