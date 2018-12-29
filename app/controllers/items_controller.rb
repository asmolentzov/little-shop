class ItemsController < ApplicationController

  def index
   if current_merchant?
     @items = current_user.items
   else
     @items = Item.enabled_items
   end
   @top_five_items = Item.five_popular('desc')
   @bottom_five_items = Item.five_popular('asc')
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
  end

  def new
    @user = current_user
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      redirect_to dashboard_items_path
      flash[:sucess] = "Your new item has been created"
    else
      flash[:sucess] = "Your new item was NOT created"
      @errors = @item.errors
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image_link, :inventory, :description, :current_price)
  end
end
