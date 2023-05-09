class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validate :last_name, :first_name, :last_name_kana, :first_name_kana,
           :postal_code, :address, :telephone_number, :is_deleted

  enum is_deleted: { not_exist: true, exist: false}

  has_many :cart_items
  has_many :orders
  has_many :shipping_addresses
  
end