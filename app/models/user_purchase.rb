class UserPurchase
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :area_id, :city, :address_line_1, :address_line_2, :phone_number

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :city
    validates :address_line_1
    validates :phone_number, format: {with: /\d{,11}/}
  end

  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    destination = Destination.create(postal_code: postal_code, area_id: area_id, city: city, address_line_1: address_line_1, address_line_2: address_line_2, phone_number: phone_number, purchase_id: purchase.id)
  end
end