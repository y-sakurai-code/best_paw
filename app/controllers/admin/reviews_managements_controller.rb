class Admin::ReviewsManagementsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    @reviews = Review.all.order(created_at: :desc)
  end

  def show
    @review = Review.find(params[:id])
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy
    redirect_to admin_reviews_managements_index_path, notice: "レビューを削除しました"
  end

  def destroy_comment
    review_comment = ReviewComment.find(params[:review_comment_id])
    review = review_comment.review
    review_comment.destroy
    redirect_to admin_reviews_management_path(review), notice: "レビューコメントを削除しました"
  end

end
