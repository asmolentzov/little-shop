class Dashboard::ItemsController < ApplicationController
  
  def index
   if current_merchant?
     @items = current_user.items
   else
     @items = Item.enabled_items
   end
   @top_five_items = Item.five_popular('desc')
   @bottom_five_items = Item.five_popular('asc')
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:format])
    if item.enabled?
      item.update(:enabled => false)
      flash[:success] = "#{item.name} is no longer for sale."
      redirect_to dashboard_items_path
    end
  end
end