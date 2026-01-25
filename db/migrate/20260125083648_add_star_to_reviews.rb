class AddStarToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :star, :float
  end
end
