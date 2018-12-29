class UsersController < ApplicationController
  before_action :require_merchant_user, only: [:show]

  def index
    if current_admin?
      @merchants = User.merchant
    else
      @merchants = User.enabled_merchants
    end
    @top_merchants_by_quantity = User.merchants_by_quantity
    @top_merchants_by_price = User.merchants_by_price
    @top_merchants_by_time = User.merchants_by_time[0..2]
    @bottom_merchants_by_time = User.merchants_by_time.reverse[0..2]
    @top_states = User.top_states
    @top_cities = User.top_cities
    @biggest_orders = Order.biggest_orders
  end

  def show
    @merchant_pending_orders = Order.merchant_pending_orders(current_user.id)
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
      @errors = @user.errors
      if @errors.full_messages.include?("Email has already been taken")
        @user.email = nil
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
      @user = User.find(params[:id])
      @errors = current_user.errors
      render :edit
    end
  end


  private

  def user_params
      params.require(:user).permit(:name, :street, :city, :state, :zip, :email, :password)
  end
end
