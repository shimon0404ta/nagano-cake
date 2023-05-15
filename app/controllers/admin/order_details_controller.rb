class Admin::OrderDetailsController < ApplicationController
  def update
    order_detail = OrderDetail.find(params[:id])
		order_detail.update(order_detail_params)

		case order_detail.making_status
		 when "in_production"
				order_detail.order.update(status: "in_production")
		 when "production_complete"
			if order_detail.order.order_details.all?{|order_detail| order_detail.making_status == "production_complete"}
				order_detail.order.update(status: "shipping_preparation")
			end
		end

		redirect_to admin_order_path(order_detail.order.id)
  end


  private
  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
