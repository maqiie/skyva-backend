class CartsController < ApplicationController
    def show
      @cart = Cart.find(params[:id])
    end
  
    def add_item
      @cart = Cart.find(params[:id])
      @item = @cart.items.build(item_params)
      if @item.save
        redirect_to @cart, notice: 'Item added to cart successfully.'
      else
        render :show
      end
    end
  
    private
  
    def item_params
      params.require(:item).permit(:name, :price, :quantity)
    end
  end
  