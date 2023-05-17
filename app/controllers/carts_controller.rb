
class CartsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :add_item

  def add_item
    jewelry = Jewelry.find(params[:jewelryId])
    cart = current_cart
  
    cart_item = cart.cart_items.find_by(jewelry: jewelry)
    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      cart_item = cart.cart_items.build(jewelry: jewelry)
      cart_item.save
    end
  
    # Assign the cart_id to the newly created cart_item
    cart_item.update(cart: cart)
  
    render json: { message: "Item added to cart" }
  end
  

  private

  def current_cart
    # Create a dummy cart or use a default cart
    # Modify the logic based on your requirements

    # Example implementation using a session-based cart
    session[:cart] ||= Cart.create

    # Return the current cart
    session[:cart]
  end
end
