class Profile::OrdersController < ApplicationController
  before_action :require_default_user

  def index
  end

  def show
    @order = Order.find(params[:id])
  end

  def create
    order = Order.create(status: :pending, user: current_user)
    @cart.contents.each do |item_id, quantity|
      item = Item.find(item_id)
      order.order_items.create(item: item, quantity: quantity, order_price: item.current_price, fulfilled: false)
    end
    flash[:notice] = "Your order has been created!"
    @cart.empty
    redirect_to profile_path
  end

  def update
    order = Order.find(params[:id])
      order.order_items.each do |item|
        item.cancel
      end
    order.update(status: "cancelled")
    flash[:notice] = "Your order has been cancelled"
    redirect_to profile_path(current_user)
  end

end
