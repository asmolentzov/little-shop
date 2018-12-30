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
  
end