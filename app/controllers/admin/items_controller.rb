class Admin::ItemsController < ApplicationController
  def index
    @items = User.find(params[:merchant_id]).items
    @top_five_items = Item.five_popular('desc')
    @bottom_five_items = Item.five_popular('asc')
  end
end