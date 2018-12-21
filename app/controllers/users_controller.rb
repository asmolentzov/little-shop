class UsersController < ApplicationController

  before_action :require_merchant_user, only: [:show]

  def index
    if current_admin?
      @merchants = User.merchant
    elsif
      @merchants = User.enabled_merchants
    end
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

  def update
  to_update = User.find(params[:id])
    if current_user.update(user_params)
      flash[:success] = 'You have updated your profile'
      redirect_to profile_path
    elsif
      current_user.errors.each do |attr, msg|
        if msg == "can't be blank"
          flash[:field_alert] = 'Required fields are missing'
        elsif attr == :email && msg == "has already been taken"
          flash[:email_alert] = 'Email address is already in use'
          current_user.email = nil
        end
      redirect_to profile_edit_path
      end
    else
      binding.pry
      to_update[:enabled] = true
      flash[:success] = "#{to_update.name} is now enabled"
      redirect_to users_path
    end
  end

  private

  def user_params
    if current_admin?
      params.fetch(:user_id, {}).permit(:name, :street, :city, :state, :zip, :email, :password, :enabled)
    else
      params.require(:user).permit(:name, :street, :city, :state, :zip, :email, :password)
    end
  end
end
