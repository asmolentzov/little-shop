class ItemsController < ApplicationController

  def index
   @items = Item.enabled_items
   @top_five_items = Item.five_popular('desc')
   @bottom_five_items = Item.five_popular('asc')
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    item = Item.find(params[:id])
    Item.delete(item)
    flash[:notice] = "Item ##{item.id} has been deleted"
    redirect_to dashboard_items_path
  end

end
