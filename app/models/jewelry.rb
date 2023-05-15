class Jewelry < ApplicationRecord
  has_one_attached :image
  has_many :cart_items, as: :item
  attribute :name, :string
  attribute :title, :string
end
