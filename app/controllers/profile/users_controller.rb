class Profile::UsersController < ApplicationController
  before_action :require_default_user
  def show
    
  end
  
  def edit
    @user = current_user
  end
  
  private
  
  def require_default_user
    unless current_default?
      render file: "public/404", status: 404, layout: false
    end
  end
end