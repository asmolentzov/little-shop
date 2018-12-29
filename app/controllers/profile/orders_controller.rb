class Profile::OrdersController < ApplicationController
  before_action :require_default_user

  def index
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    order = Order.create(status: :pending, user: current_user)
    order_items = @cart.contents.map do |item_id, quantity|
      item = Item.find(item_id)
      OrderItem.new(order: order, item: item, quantity: quantity, order_price: item.current_price, fulfilled: false)
    end
    order.order_items << order_items
    flash[:notice] = "Your order has been created!"
    redirect_to profile_path
  end
end
