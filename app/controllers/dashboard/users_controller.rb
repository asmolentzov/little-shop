class Dashboard::UsersController < ApplicationController
  
  def show
    @merchant_pending_orders = Order.merchant_pending_orders(current_user.id)
  end
end