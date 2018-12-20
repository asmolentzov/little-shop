class Profile::UsersController < ApplicationController
  before_action :require_default_user
  
  def show
    
  end
  
  def edit
    @user = current_user
  end
  
end