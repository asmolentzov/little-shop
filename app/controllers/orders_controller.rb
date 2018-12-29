class OrdersController < ApplicationController
  
  def show
    @customer = Order.find(params[:id]).user
  end
end