class Admin::UsersController < ApplicationController
  before_action :require_admin
  def index
    @users = User.default_users
  end

  def show
    @merchant = User.find(params[:id])
  end

end
