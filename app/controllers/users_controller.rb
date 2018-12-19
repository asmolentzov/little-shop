class UsersController < ApplicationController
  def index
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path
      flash[:success] = "You are now registered and logged in."
    else
        if @user.errors.details[:email] 
          flash[:alert] = 'Email address is already in use'
          @user.email = nil
        end
      render :new
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    current_user.update(user_params)
    flash[:success] = 'You have updated your profile'
    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
