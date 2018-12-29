class OrdersController < ApplicationController
  
  def show
    order = Order.find(params[:id])
    @customer = order.user
    @items = order.merchant_items(current_user)
  end
end