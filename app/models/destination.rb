class Destination < ApplicationRecord
  belongs_to :purchase
  belongs_to_active_hash :area
end
