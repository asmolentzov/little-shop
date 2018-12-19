class Admin::UsersController < ApplicationController
  before_action :require_admin
  def index
    
  end
  
  private
  
  def require_admin
    unless current_user
      render file: "public/404", status: 404, layout: false
    end
  end
end