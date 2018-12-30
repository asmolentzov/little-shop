class Dashboard::UsersController < ApplicationController
  before_action :require_merchant_user
  
  def show
    @merchant_pending_orders = Order.merchant_pending_orders(current_user.id)
  end
end