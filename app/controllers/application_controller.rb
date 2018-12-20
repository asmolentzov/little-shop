class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_default?, :current_merchant?, :current_admin?,
                :require_default_user, :require_merchant_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_default?
    current_user && current_user.default?
  end

  def current_merchant?
    current_user && current_user.merchant?
  end

  def current_admin?
    current_user && current_user.admin?
  end
  
  def require_default_user
    unless current_default?
      render file: "public/404", status: 404, layout: false
    end
  end
  
  def require_merchant_user
    unless current_merchant?
      render file: "public/404", status: 404, layout: false
    end
  end

end
