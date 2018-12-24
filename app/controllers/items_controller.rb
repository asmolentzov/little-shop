class ItemsController < ApplicationController

  def index
   if current_merchant?
     @items = current_user.items
   else
     @items = Item.all
   end

   if @cart.cart_count > 0
     last_item = Item.find(@cart.contents.keys.last)
     flash[:sucess] = "You have added #{last_item.name} to your cart"
   end
  end

  def show
    @item = Item.find(params[:id])
  end
end
