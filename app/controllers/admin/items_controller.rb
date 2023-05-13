class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def index
    @items = Item.all
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item.id)
    else
      flash[:item_create_error] = "商品の新規登録内容に不備があります"
      redirect_to new_admin_item_path
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    redirect_to admin_items_path
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to admin_item_path(item.id)
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :price, :status, :image)
  end

end
