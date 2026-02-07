class Item < ApplicationRecord
  has_one_attached :item_image

  belongs_to :admin

  enum estimated_dog_size: { S: 0, M: 1, L: 2, LL: 3 }
  enum is_active: { on_sale: 0, out_of_stock: 1, unknown: 2 }

end
