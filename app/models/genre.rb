class Genre < ApplicationRecord

  validates :name, presence: true, uniqueness: true, length: { maximum: 20 }

  has_many :items
  has_many :reviews

end
