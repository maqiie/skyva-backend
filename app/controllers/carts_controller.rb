
class CartsController < ApplicationController


  skip_before_action :verify_authenticity_token, only: :add_item

  def create
    cart = Cart.create
    session[:cart_id] = cart.id

    render json: { message: "Cart created successfully", cart_id: cart.id }
  end

  def add_item
    # Your existing code for adding an item to the cart
  end

  private

  def current_cart
    if session[:cart_id].present?
      Cart.find_by(id: session[:cart_id])
    else
      cart = Cart.create
      session[:cart_id] = cart.id
      cart
    end
  end
  
end
