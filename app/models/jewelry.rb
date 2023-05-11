puts "Loading Jewelry model"
class Jewelry < ApplicationRecord
  has_one_attached :image
end
