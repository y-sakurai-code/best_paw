class RemoveUnusedColumnsFromReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :item_id, :integer
  end
end
