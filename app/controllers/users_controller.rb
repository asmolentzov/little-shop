class UsersController < ApplicationController
  def index

  end

  def show
  end

  def new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:users).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
