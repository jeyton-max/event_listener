class Event < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :operation_settings, dependent: :destroy
  has_many :booths, dependent: :destroy
  
  has_many :shops, dependent: :destroy
  # 画像管理（Active Storage）の設定
  has_one_attached :icon_image

  # バリデーション：必須項目のチェック
  validates :name, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end