class ReviewCommentsController < ApplicationController

  def create
    review = Review.find(params[:review_id])
    comment = current_user.review_comments.new(review_comment_params)
    comment.review_id = review.id
    comment.save
    redirect_to review_path(review)
  end

  def destroy
    ReviewComment.find(params[:id]).destroy
    redirect_to review_path(params[:review_id])
 end 

  private

  def review_comment_params
   params.require(:review_comment).permit(:comment)
  end

end
