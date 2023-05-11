class JewelryController < ApplicationController
    def index
      @jewelries = Jewelry.all
      render json: @jewelries
    end
  end
  