class CartsController < ApplicationController

  def show
    @cart = Cart.new(session[:cart])
  end

end
