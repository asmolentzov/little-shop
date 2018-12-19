class OrdersController < ApplicationController
  def index
    unless current_user
      render file: "public/404", status: 404, layout: false
    end
  end
end
