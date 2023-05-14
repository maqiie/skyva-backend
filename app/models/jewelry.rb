class Jewelry < ApplicationRecord
  has_one_attached :image
  belongs_to :cart
  attribute :name, :string
  attribute :title, :string
end
