class Dashboard::OrderItemsController < ApplicationController

  def update
    order_item = OrderItem.find(params[:id])
    item = Item.find(order_item.item_id)
    order = Order.find(order_item.order_id)
    original_qty = item.inventory
    Item.find(item.id).update(inventory: (original_qty - order_item.quantity))
    OrderItem.find(order_item.id).update(fulfilled: true)
    flash[:success] = "Order item ##{order_item.id} has been fulfilled!"
    order.update_status_if_fulfilled
    if current_merchant?
      redirect_to dashboard_order_path(order)
    elsif current_admin?
      redirect_to admin_merchant_order_path(order_item.item.user, order)
    end
  end

end
