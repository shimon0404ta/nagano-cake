class Item < ApplicationRecord
  has_one_attached :image
  has_many :cart_items
  has_many :order_details
  belongs_to :genre
  
  enum status: { buy_now: true, sold_out: false}
  
  def get_item_image(width,height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpeg')
      image.attach(io: File.open(file_path), filename: 'default_image.jpeg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit: [width, height])
  end

  def with_tax_price
    (price*1.1).floor
  end
  
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0}

end
