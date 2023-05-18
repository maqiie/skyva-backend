
class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :items, through: :cart_items
  has_many :jewelries, through: :cart_items






  def create
    cart = Cart.create
    session[:cart_id] = cart.id
  
    render json: { message: "Cart created successfully", cart_id: cart.id }
  end
  

  def add_jewelry(jewelry)
    cart_item = cart_items.find_by(jewelry_id: jewelry.id)
    
    if cart_item
      cart_item.quantity += 1
      cart_item.save
    else
      cart_item = cart_items.build(jewelry: jewelry)
      cart_item.save
    end
    
    cart_item
  end
  
  
  
end
