class ItemsController < ApplicationController

  def index
   if current_merchant?
     @items = current_user.items
   else
     @items = Item.all
   end
   @top_five_items = Item.five_popular('desc')
   @bottom_five_items = Item.five_popular('asc')
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    Item.destroy(params[:id])
    redirect_to dashboard_items_path
  end
end
