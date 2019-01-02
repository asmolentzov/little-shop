class Dashboard::OrdersController < ApplicationController
  before_action :require_merchant_user
  
  def show
    order = Order.find(params[:id])
    @customer = order.user
    @items_with_quantity = order.merchant_items_with_quantity(current_user.id)
  end
end