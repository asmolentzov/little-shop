class Dashboard::ItemsController < ApplicationController
  before_action :require_merchant_user
  
  def index
   @items = current_user.items
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
    if params[:item]
      if item.update(item_params)
        flash[:success] = "Item ##{item.id} has been updated"
      else
        @item = Item.find(params[:id])
        @errors = item.errors
        render :edit
        return
      end
    else
      if item.enabled?
        item.update(:enabled => false)
        flash[:success] = "#{item.name} is no longer for sale."
      end
    end
    redirect_to dashboard_items_path
  end
  
  def destroy
    item = Item.find(params[:id])
    Item.delete(item)
    flash[:notice] = "Item ##{item.id} has been deleted"
    redirect_to dashboard_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :image_link, :inventory, :description, :current_price)
  end
end