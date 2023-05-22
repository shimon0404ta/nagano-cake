class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @shipping_address = ShippingAddress.where(customer_id: current_customer.id)
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    destination = params[:order][:select_address]
    @order.postage = 800
    @order.order_status = 0
    @total_price = 0
    @cart_items.each do |cart_item|
      @total_price += (cart_item.item.price * 1.1 * cart_item.amount).floor
    end
    @order.total_price = @total_price + @order.postage
    
    if destination == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif destination == "1"
      @shipping_address = ShippingAddress.find(params[:order][:shipping_address_id])
      @order.postal_code = @shipping_address.postal_code
      @order.address = @shipping_address.address
      @order.name = @shipping_address.name
    elsif destination == "2"
      @shipping_address = ShippingAddress.new()
      @shipping_address.postal_code = params[:order][:postal_code]
      @shipping_address.address = params[:order][:address]
      @shipping_address.name = params[:order][:name]
      @shipping_address.customer_id = current_customer.id
      if @shipping_address.save
        @order.postal_code = @shipping_address.postal_code
        @order.address = @shipping_address.address
        @order.name = @shipping_address.name
      else
        render :new
      end
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = current_customer.cart_items
    @cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.order_id = @order.id
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.making_status = 0
      @order_detail.ordered_price = @order.total_price
      @order_detail.save
    end
    @cart_items.destroy_all
    redirect_to orders_thanks_path
  end
  
  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id).order('created_at DESC')
  end

  def show
    @order = Order.find(params[:id])
  end
  
  private
  
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :address, :name, :postage, :order_status, :total_price)
  end
end
