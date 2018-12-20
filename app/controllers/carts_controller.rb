class CartsController < ApplicationController
  
  def show
    unless current_default? || !current_user
      render file: "public/404", status: 404, layout: false
    end
  end
end