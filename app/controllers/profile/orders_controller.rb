class Profile::OrdersController < ApplicationController
  before_action :require_default_user

  def index
  end

  def show
    @order = Order.find(params[:id])
  end
  
  def create
    
  end
end
