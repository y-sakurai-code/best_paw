class CreateFavoritesReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites_reviews do |t|
      t.integer :user_id
      t.integer :reviews_id

      t.timestamps
    end
  end
end
