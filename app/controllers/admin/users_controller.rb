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
    if user[:enabled] == true
      user.update(:enabled => false)
      flash[:notice] = "#{user.name} is now disabled"
    elsif
      user[:enabled] == false
      user.update(:enabled => true)
      flash[:notice] = "#{user.name} is now enabled"
    end
    redirect_to merchants_path
  end

end
