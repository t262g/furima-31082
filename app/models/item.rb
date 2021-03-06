class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_cost
  belongs_to_active_hash :area
  belongs_to_active_hash :delivery_day

  belongs_to :user
  has_one_attached :image
  has_one :purchase

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :area_id
    validates :delivery_day_id
  end

  with_options presence: true do
    validates :image
    validates :name
    validates :price
    validates :explanation
    validates :category_id
    validates :condition_id
    validates :shipping_cost_id
    validates :area_id
    validates :delivery_day_id
  end

  validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }
end
