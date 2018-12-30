class Admin::MerchantsController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @user_role = @user.role
    if @user_role == 'default' 
      redirect_to admin_user_path(@user)
    end
    @orders = @user.orders
  end
end