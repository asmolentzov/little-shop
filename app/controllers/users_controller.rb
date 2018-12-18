class UsersController < ApplicationController
  def index

  end

  def show
    
  end

  def new

  end

  private

  def user_params
    params.require(:users).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
