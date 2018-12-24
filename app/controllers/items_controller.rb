class ItemsController < ApplicationController

  def index
   if current_merchant?
     @items = current_user.items
     @top_five_items = Item.five_popular('desc')
     @bottom_five_items = Item.five_popular('asc')
   else
     @items = Item.all
     @top_five_items = Item.five_popular('desc')
     @bottom_five_items = Item.five_popular('asc')
   end
  end

  def show
    @item = Item.find(params[:id])
  end
end
