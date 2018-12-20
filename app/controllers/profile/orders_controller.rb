class Profile::OrdersController < ApplicationController
    before_action :require_default_user
    
    def index
      
    end
    
    private
    
    def require_default_user
      unless current_default?
        render file: "public/404", status: 404, layout: false
      end
    end
end
