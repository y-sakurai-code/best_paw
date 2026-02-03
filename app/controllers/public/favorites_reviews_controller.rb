class Public::FavoritesReviewsController < ApplicationController

  def create
    @review = Review.find(params[:review_id])
    favorite = current_user.favorites_reviews.new(review_id: @review.id)
    favorite.save
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    favorite = current_user.favorites_reviews.find_by(review_id: @review.id)
    favorite.destroy
    redirect_to review_path(@review)
  end

end
