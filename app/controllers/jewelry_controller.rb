class JewelryController < ApplicationController
  # before_action :authorize_request



  def index
    @jewelries = Jewelry.all
    render json: @jewelries.as_json(only: [:id, :name, :price,  :description])
  end

  def new
    @jewelry = Jewelry.new
  end

  def create
    @jewelry = Jewelry.new(jewelry_params)
  
    if @jewelry.save
      render json: @jewelry, status: :created
    else
      render json: @jewelry.errors, status: :unprocessable_entity
    end
  end


  
  def destroy
    @jewelry = Jewelry.find(params[:id])
    @jewelry.destroy
    redirect_to jewelries_path
  end

  private

  def jewelry_params
    params.require(:jewelry).permit(:image, :title, :price, :description)
  end
  


  def authorize_request
    # Authorization logic goes here
    # You can check if the user has the necessary permissions to access the requested resource
    # If the authorization fails, you can raise an exception or redirect the user to an appropriate page
  end
end
