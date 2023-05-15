class Public::ItemsController < ApplicationController
  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

  def index
    @count_items = Item.all
    @items = Item.page(params[:page])
    @genres = Genre.all
  end
  
end
