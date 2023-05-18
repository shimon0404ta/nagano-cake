class Public::ShippingAddressesController < ApplicationController
  before_action :authenticate_customer

  def create
    @shipping_address = Shipping_address.new(address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      redirect_to shipping_addresses_path
    else
      @shipping_address = Shipping_address.new
      @shipping_addresses = current_customer.shipping_addresses
      flash[:notice] = "error"
      render :index
    end
  end

  def index
    @shipping_address = Shipping_Address.new
    @shipping_addresses = current_customer.shipping_addresses
  end

  def edit
    @shipping_address = Shipping_address.find(params[:id])
  end

  def update
    @shipping_address = Shipping_address.find(params[:id])
    if @shipping_address.update(shipping_address_params)
      redirect_to shipping_addresses_path
    else
      render :edit
    end
  end

  def destroy
    @shipping_address = Shipping_address.find(params[:id])
    @shipping_address.destroy
    redirect_to shipping_addresses_path
  end

  private

  def address_params
    params.require(:shippingaddress).permit(:postal_code, :address, :name, :customer_id)
  end

end
