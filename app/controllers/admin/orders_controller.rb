class Admin::OrdersController < ApplicationController
  before_action :require_admin

def show
  @order = Order.find(params[:id])
end

end
