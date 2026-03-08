class AddDetailsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :item_name, :string
    add_reference :reviews, :genre, null: false, foreign_key: true
  end
end
