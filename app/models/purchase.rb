class Purchase < ApplicationRecord
  belongs_to_active_hash :area
  belongs_to :user
  belongs_to :item
  has_one :destination
end
