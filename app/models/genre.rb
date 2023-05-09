class Genre < ApplicationRecord
  has_many :items

  validates :genre, presence: true
end
