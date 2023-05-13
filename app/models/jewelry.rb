class Jewelry < ApplicationRecord
  has_one_attached :image

  attribute :name, :string
  attribute :title, :string
end
