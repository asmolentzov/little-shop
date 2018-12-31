class ItemsController < ApplicationController

  def index
   @items = Item.enabled_items.includes(:user)
   @top_five_items = Item.five_popular('desc')
   @bottom_five_items = Item.five_popular('asc')
  end

  def show
    @item = Item.find(params[:id])
  end
end
