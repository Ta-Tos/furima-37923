class ShippingAddress < ApplicationRecord
  belongs_to :purcharser

  with_options presence: true do
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :municipality, :address_number
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, length: { minimum: 10, message: "is too short"}
  end
  validates :phone_number, format: { with: /\A[0-9０-９]+\z/, message: "is invalid. Input only number"}
end
