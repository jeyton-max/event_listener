class Booth < ApplicationRecord
  has_many :assignments, dependent: :destroy
end