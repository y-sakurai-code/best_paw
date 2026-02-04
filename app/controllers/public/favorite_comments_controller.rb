class Public::FavoriteCommentsController < ApplicationController

    def create
    @review_comment = ReviewComment.find(params[:review_comment_id])
    favorite_comment = current_user.favorite_comments.new(review_comment_id: @review_comment.id)
    favorite_comment.save
    @review = @review_comment.review
    redirect_to review_path(@review)
  end

  def destroy
    @review_comment = ReviewComment.find(params[:review_comment_id])
    favorite_comment = current_user.favorite_comments.find_by(review_comment_id: @review_comment.id)
    favorite_comment.destroy
    @review = @review_comment.review
    redirect_to review_path(@review)
  end

end
