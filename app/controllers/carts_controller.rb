class CartsController < ApplicationController

  def show
    unless current_default? || !current_user
      render file: "public/404", status: 404, layout: false
    end
    @cart = Cart.new(session[:cart])
    @cart_items = Item.find(@cart.contents.keys)
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
