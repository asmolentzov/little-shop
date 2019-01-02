class Admin::OrdersController < ApplicationController
  before_action :require_admin

def show
  @order = Order.find(params[:id])
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
