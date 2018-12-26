class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.default_users
  end

  def show
    @user = User.find(params[:id])
    @user_role = @user.role
  end

  def create

  end

  def update
    user = User.find(params[:id])
    if params[:upgrade]
      User.find(params[:id]).update(:role => 1)
      flash[:notice] = 'This user has been upgraded.'
      redirect_to admin_merchant_path(user)
      return
    end
    if user.enabled == true
      user.update(:enabled => false)
      flash[:notice] = "#{user.name} is now disabled"
    elsif
      user.enabled == false
      user.update(:enabled => true)
      flash[:notice] = "#{user.name} is now enabled"
    end
    if user.role == "merchant"
      redirect_to "/merchants"
    else
      redirect_to admin_users_path
    end
  end

end
