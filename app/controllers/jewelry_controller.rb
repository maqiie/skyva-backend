class JewelryController < ApplicationController
  # before_action :authorize_request
  # before_action :authenticate_user!

  skip_before_action :verify_authenticity_token, only: [:add_to_cart, :create]


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





  def add_to_cart
    jewelry = Jewelry.find(params[:id])
    cart = current_user.cart # Assuming you have a `cart` association on the User model

    cart_item = cart.cart_items.find_by(jewelry_id: jewelry.id)

    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      cart_item = cart.cart_items.build(jewelry: jewelry)
      cart_item.save
    end

    render json: { message: "Item added to cart successfully" }
  end

  private

  def authenticate_user!
    token = request.headers['Authorization'].to_s.split(' ').last
    decoded_token = JWT.decode(token, 'your_secret_key', true, algorithm: 'HS256').first

    user_id = decoded_token['user_id']
    @current_user = User.find(user_id)
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end

  def current_user
    @current_user
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
