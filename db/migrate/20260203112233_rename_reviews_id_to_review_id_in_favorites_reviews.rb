class RenameReviewsIdToReviewIdInFavoritesReviews < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorites_reviews, :reviews_id, :review_id
  end
end
