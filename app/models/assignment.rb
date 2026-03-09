class Assignment < ApplicationRecord
  belongs_to :event
  belongs_to :shop
  belongs_to :booth
end
