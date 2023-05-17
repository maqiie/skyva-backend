class JewelryController < ApplicationController
  # before_action :authorize_request

  skip_before_action :verify_authenticity_token, only: :add_to_cart


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




  # def add_to_cart
  #   @jewelry = Jewelry.find(params[:id])
  #   if @jewelry
  #     cart_item = CartItem.create(cart_id: current_user.cart.id, jewelry_id: @jewelry.id)
  #     if cart_item.persisted?
  #       render json: { message: 'Jewelry item added to cart.' }, status: :ok
  #     else
  #       render json: { error: 'Failed to add jewelry item to cart.' }, status: :unprocessable_entity
  #     end
  #   else
  #     render json: { error: 'Jewelry item not found.' }, status: :not_found
  #   end
  # end
  
  def add_to_cart
    @jewelry = Jewelry.find(params[:id])
    if @jewelry
      cart = Cart.first_or_create # Retrieve the first cart or create a new one if it doesn't exist
      cart_item = cart.cart_items.build(jewelry: @jewelry) # Create a new cart item associated with the jewelry
      cart_item.cart = cart # Assign the cart to the cart_item
      if cart_item.save
        render json: { message: 'Jewelry item added to cart.' }, status: :ok
      else
        render json: { error: 'Failed to add jewelry item to cart.' }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Jewelry item not found.' }, status: :not_found
    end
  end
  
  
  
  def destroy
    @jewelry = Jewelry.find(params[:id])
    @jewelry.destroy
    puts 'Jewelry item was successfully deleted.'
  
  end
  

  private

  def jewelry_params
    params.require(:jewelry).permit(:image, :name, :price, :description)
  end
  


  def authorize_request
    # Authorization logic goes here
    # You can check if the user has the necessary permissions to access the requested resource
    # If the authorization fails, you can raise an exception or redirect the user to an appropriate page
  end
end
