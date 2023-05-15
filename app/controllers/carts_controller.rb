# # app/controllers/carts_controller.rb
# class CartsController < ApplicationController
#   skip_before_action :verify_authenticity_token, only: :add_item
#   def show
#     @cart = current_user.cart
#   end

#   # def add_item
#   #   # @cart = current_user.cart # Assuming you have authentication and a current_user method
#   #   @jewelry = Jewelry.find(params[:jewelryId]) # Fetch the jewelry item based on the ID

#   #   if @cart.items << @jewelry # Add the jewelry item to the cart's items collection
#   #     render json: { message: 'Item added to cart successfully.' }
#   #   else
#   #     render json: { error: 'Failed to add item to cart.' }, status: :unprocessable_entity
#   #   end
#   # end


#   def add_item
#     @jewelry = Jewelry.find(params[:jewelryId])
#     @cart = get_cart # Custom method to retrieve or create the cart
  
#     if @cart.items << @jewelry
#       redirect_to @cart, notice: 'Item added to cart successfully.'
#     else
#       render :show
#     end
#   end
  
#   private
  
#   def get_cart
#     if session[:cart_id]
#       Cart.find(session[:cart_id])
#     else
#       cart = Cart.create
#       session[:cart_id] = cart.id
#       cart
#     end
#   end
  
# end
class CartsController < ApplicationController

  skip_before_action :verify_authenticity_token, only: :add_item
  def add_item
    jewelry = Jewelry.find(params[:jewelryId])
    cart = get_cart
  
    cart_item = cart.cart_items.find_by(jewelry: jewelry)
    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      cart_item = cart.cart_items.create(jewelry: jewelry)
    end
  
    render json: { message: "Item added to cart" }
  end
  

  private

  def get_cart
    Cart.create
  end
  
end
