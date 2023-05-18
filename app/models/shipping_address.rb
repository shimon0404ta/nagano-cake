class ShippingAddress < ApplicationRecord
  belongs_to :customer
    
  validates :postal_code, presence: true
  validates :address,     presence: true
  validates :name,        presence: true
    
end
