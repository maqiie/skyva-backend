class Jewelry < ApplicationRecord
  has_one_attached :image
  attribute :name, :string
  attribute :title, :string
  has_many :cart_items, as: :item
  has_many :carts, through: :cart_items
  
end
