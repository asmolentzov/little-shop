class Dashboard::ItemsController < ApplicationController
  
  def index
   if current_merchant?
     @items = current_user.items
   else
     @items = Item.enabled_items
   end
   @top_five_items = Item.five_popular('desc')
   @bottom_five_items = Item.five_popular('asc')
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
      @errors = @item.errors
      render :new
    end
  end
  
  def edit
    @item = Item.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
    if item.enabled?
      item.update(:enabled => false)
      flash[:success] = "#{item.name} is no longer for sale."
      redirect_to dashboard_items_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :image_link, :inventory, :description, :current_price)
  end
end