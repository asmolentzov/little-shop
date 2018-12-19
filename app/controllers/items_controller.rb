class ItemsController < ApplicationController

  def index
    if current_merchant?
     @items = current_user.items
    else
     @items = Item.all
    end
  end
end
