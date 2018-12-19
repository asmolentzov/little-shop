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
      if @user.errors.full_messages.first == "Email has already been taken"
        flash[:alert] = 'Email address is already in use'
        @user.email = nil
      end
      @user.errors.each do |attr, msg|
        if msg == "can't be blank"
          flash[:alert] = 'Required fields are missing'
        elsif attr == :email && msg == "has already been taken"
          flash[:alert] = 'Email address is already in use'
          @user.email = nil
        end
      end
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
