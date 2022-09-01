class Item < ApplicationRecord
  with_options presence: true do
    validates :image, :item_name, :item_explain
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
    validates :category_id, :item_condition_id, :delivery_charge_id, :prefecture_id, :shipping_day_id,
              numericality: { other_than: 1, message: "can't be blank" }
  end
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'is out of setting range' }

  belongs_to :user
  has_one :purcharser
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :delivery_charge
  belongs_to :shipping_day
  belongs_to :item_condition
  belongs_to :prefecture
end
