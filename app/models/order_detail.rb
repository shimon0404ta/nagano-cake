class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order
  
  enum making_status: {
    non_production: 0,
    awaiting_production: 1,
    in_production: 2,
    production_complete: 3
  }
end
