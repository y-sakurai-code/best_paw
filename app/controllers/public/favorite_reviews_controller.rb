class Public::FavoriteReviewsController < ApplicationController

  belongs_to :user
  belongs_to :review

  validates :user_id, uniqueness: { scope: :review_id }

  def create
    @review = Review.find(params[:review_id])
    favorite = current_user.favorite_reviews.new(review_id: @review.id)
    if favorite.save
      @review.create_notification_favorite_reviews!(current_user)
    end
    redirect_to review_path(@review)
  end

  def destroy
    @review = Review.find(params[:review_id])
    favorite = current_user.favorite_reviews.find_by(review_id: @review.id)
    favorite.destroy
    redirect_to review_path(@review)
  end

end
