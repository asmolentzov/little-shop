class CartsController < ApplicationController

  def show
    if current_merchant? || current_admin?
      render file: "public/404", status: 404, layout: false
    else
      @cart_items = Item.find(@cart.contents.keys)
    end
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
