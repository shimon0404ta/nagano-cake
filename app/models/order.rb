class Order < ApplicationRecord
  has_many :order_details
  belongs_to :customer
    
  enum method_payment: { credit_card: 0, transfer: 1}
  enum order_status: { wait: 0, payment_check: 1, making: 2, ready_to_ship: 3, goal: 4}

end
