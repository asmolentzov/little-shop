class Admin::OrdersController < ApplicationController
  before_action :require_admin

  def show
    if params[:merchant_id]
      order = Order.find(params[:id])
      @customer = order.user
      @items_with_quantity = order.merchant_items_with_quantity(params[:merchant_id])
      render '/dashboard/orders/show'
    else
      @order = Order.find(params[:id])
    end
  end

  def update
    order = Order.find(params[:id])
      order.order_items.each do |item|
        item.cancel
      end
    order.update(status: "cancelled")
    flash[:notice] = "Your order has been cancelled"
    redirect_to admin_user_path(order.user_id)
  end
end
