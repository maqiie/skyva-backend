class Cart < ApplicationRecord
  has_many :cart_items
  has_many :items, through: :cart_items
  belongs_to :user
  has_and_belongs_to_many :jewelries
  has_many :jewelries, through: :cart_items
end
