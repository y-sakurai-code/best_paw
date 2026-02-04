class RenameFavoritesReviewsToFavoriteReviews < ActiveRecord::Migration[6.1]
  def change
    rename_table :favorites_reviews, :favorite_reviews
  end
end
