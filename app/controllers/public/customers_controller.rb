class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customers_my_page_path
    else
      flash[:customer_edit_error] = "項目は必ずご入力ください"
      redirect_to customers_edit_path
    end
  end
  
  def unsubscribe
  end
  
  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end
  
  private
  
  def customer_params
    params.require(:customer).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email
      )
  end
  
end