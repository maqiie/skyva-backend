class JewelryController < ApplicationController

  # protect_from_forgery with: :null_session


    def index
      @jewelries = Jewelry.all
      render json: @jewelries
    end

    def create
      @jewelry = Jewelry.new(jewelry_params)
      if @jewelry.save
        redirect_to @jewelry, notice: "Jewelry item was successfully created."
      else
        render :new
      end
    end
    

      
      private

      def jewelry_params
        params.require(:jewelry).permit(:image, :price, :description, :title)
      end
      
end
  