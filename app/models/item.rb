class Item < ApplicationRecord
  has_one_attached :item_image

  belongs_to :admin
  belongs_to :genre

  enum estimated_dog_size: { "超小型": 0, "小型": 1, "中型": 2, "大型": 3 }
  enum is_active: { on_sale: 0, out_of_stock: 1, unknown: 2 }

end
