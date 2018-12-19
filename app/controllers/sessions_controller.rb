class SessionsController < ApplicationController
  def new

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
    redirect_to root_path
  end
end
