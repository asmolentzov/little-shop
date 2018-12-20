class CartsController < ApplicationController

  def show
    @cart = Cart.new(session[:cart])
  end

  def create
    item = Item.find(params[:item_id])
    item_id_str = item.id.to_s
    session[:cart] ||= Hash.new(0)
    session[:cart][item_id_str] ||= 0
    session[:cart][item_id_str] += 1
    redirect_to items_path
  end

end
