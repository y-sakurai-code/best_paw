class RenameReviewCommentsIdToReviewCommentIdInFavoriteComments < ActiveRecord::Migration[6.1]
  def change
    rename_column :favorite_comments, :review_comments_id, :review_comment_id
  end
end
