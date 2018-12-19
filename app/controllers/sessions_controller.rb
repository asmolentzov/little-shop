class SessionsController < ApplicationController
  def new
    if current_user && current_user.default?
      flash[:alert] = 'You are already logged in'
      redirect_to profile_path
    elsif current_user && current_user.merchant?
      flash[:alert] = 'You are already logged in'
      redirect_to dashboard_path
    elsif current_user && current_user.admin?
      flash[:alert] = 'You are already logged in'
      redirect_to root_path
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged In Successfully"
      if user.default?
        redirect_to profile_path
      elsif user.merchant?
        redirect_to dashboard_path
      elsif user.admin?
        redirect_to root_path
      end
    else
      render :new
    end
  end

  def destroy
    flash[:success] = 'Successfully Logged Out'
    redirect_to root_path
  end
end
