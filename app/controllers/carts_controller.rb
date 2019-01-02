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
    flash[:sucess] = "You have added #{item.name} to your cart"
  end

  def destroy
    @cart.empty
    redirect_to cart_path
  end


  def update
    id = params[:format]
    if Item.find(id).inventory > @cart.contents[id].to_i
      @cart.contents[id] += params[:quantity].to_i
    else
      flash[:notice] = "The merchant does not have enough inventory"
    end

    if params[:quantity] == nil || @cart.contents[id] == 0
      @cart.contents.except!(id)
    end
    redirect_to cart_path
  end
end
