class Dashboard::UsersController < ApplicationController
  before_action :require_merchant_user
  
  def show
    @merchant_pending_orders = current_user.merchant_pending_orders
    @merchant_top_five_items = current_user.merchant_top_five_items
    @merchant_units_sold = current_user.merchant_units_sold
    @merchant_percent_sold = current_user.merchant_percent_sold
    @merchant_top_states = current_user.merchant_top_states
    @merchant_top_cities = current_user.merchant_top_cities
    @merchant_top_order_user = current_user.merchant_top_order_user
    @merchant_top_units_user = current_user.merchant_top_units_user
    @merchant_highest_spending_users = current_user.merchant_highest_spending_users
  end
end