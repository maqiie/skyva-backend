puts "Loading Jewelry model"

class JewelryController < ApplicationController
  def index
    @jewelries = Jewelry.all
  end
end
