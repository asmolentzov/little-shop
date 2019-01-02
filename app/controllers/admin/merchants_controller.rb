class Admin::MerchantsController < ApplicationController

  def show
    @user = User.find(params[:id])
    if @user.role == 'default'
      redirect_to admin_user_path(@user)
    end
    @orders = @user.orders
    @merchant_pending_orders = @user.merchant_pending_orders
  end

  def update
    user = User.find(params[:merchant_id])

    if user.enabled == true
      user.update(:enabled => false)
      flash[:notice] = "#{user.name} is now disabled"
    elsif
      user.enabled == false
      user.update(:enabled => true)
      flash[:notice] = "#{user.name} is now enabled"
    end

    redirect_to merchants_path
  end
end
