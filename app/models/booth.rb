class Booth < ApplicationRecord
  belongs_to :event
  has_many :assignments, dependent: :destroy

  # バリデーション
  validates :booth_code, presence: true
  validates :is_flexible, inclusion: { in: [true, false] }
  validates :is_admin_only, inclusion: { in: [true, false] }
end