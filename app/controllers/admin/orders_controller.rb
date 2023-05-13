class Admin::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_price = 0
    @order_details.each do |order_detail|
      @total_price += (order_detail.item.price * 1.1 * order_detail.amount).floor
    end
  end
  
  def update
    order = Order.find(params[:id])
    order_details = order.order_details
    order.update(order_params)
    
    if order.status == "payment_confirmationunder"
      order_details.update_all(making_status: "awaiting_production")
    end
		redirect_to admin_order_path(order.id)
  end
  
  private
  
  def order_params
    params.require(:order).permit(:order_status)
  end
end
