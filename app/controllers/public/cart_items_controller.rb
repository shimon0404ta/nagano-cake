class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    @update_cart_item = CartItem.find_by(item: @cart_item.item)
    if @update_cart_item.present? && @cart_item.valid?
      @cart_item.amount += @update_cart_item.amount
      @update_cart_item.destroy
    end
    if @cart_item.save
      flash[:notice] = "#{@cart_item.item.name}をカートに追加しました。"
      redirect_to cart_items_path
    else
      @item = Item.find(params[:cart_item][:item_id])
      @cart_item = CartItem.new
      flash[:alert] = "個数を選択してください。"
      render "public/items/show"
    end
  end
    #@cart_item = CartItem.new(cart_item_params)
    #@cart_item.customer_id = current_customer.id
    #if @cart_item.save
      #redirect_to cart_items_path
    #else
      #redirect_back(fallback_location: items_path)
      #flash[:notice] = "個数を選択してください。"
    #end
  #end

  def index
    @cart_items = current_customer.cart_items
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price * 1.1 * cart_item.amount).floor
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items
    @cart_items.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id, :image)
  end

end
