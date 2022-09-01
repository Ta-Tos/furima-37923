class Order
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :municipality, :address_number, :building_name, :phone_number,
                :purcharser_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality, :address_number, :item_id, :user_id
    validates :phone_number, length: { minimum: 10, message: 'is too short' }
  end
  validates :phone_number, length: { maximum: 11, message: 'is too long' }
  validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'is invalid. Input only number' }

  def save
    purcharser = Purcharser.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality,
                           address_number: address_number, building_name: building_name, phone_number: phone_number, purcharser_id: purcharser.id)
  end
end
