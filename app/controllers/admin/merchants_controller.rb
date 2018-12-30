class Admin::MerchantsController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @user_role = @user.role
    @orders = @user.orders
  end
end