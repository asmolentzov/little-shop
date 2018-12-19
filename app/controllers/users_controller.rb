class UsersController < ApplicationController
  def index
    @merchants = User.enabled_merchants
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
      @user.errors.each do |attr, msg|
        if msg == "can't be blank"
          flash[:field_alert] = 'Required fields are missing'
        elsif attr == :email && msg == "has already been taken"
          flash[:email_alert] = 'Email address is already in use'
          @user.email = nil
        end
      end
      render :new
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    if current_user.update(user_params)
      flash[:success] = 'You have updated your profile'
      redirect_to profile_path
    else
      flash[:field_alert] = 'Required fields are missing'
      redirect_to profile_edit_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
