class Admin::UsersController < ApplicationController

  def index
    @users = Users.where(role: default)
  end

end
