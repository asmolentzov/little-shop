class ItemsController < ApplicationController

  def index
   if current_merchant?
     @items = current_user.items
   else
     @items = Item.all
   end
  end

  def show
    @item = Item.find(params[:id])
  end
end
