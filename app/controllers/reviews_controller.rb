class ReviewsController < ApplicationController
  def new
  end

  def index
  end

  def show
  end

  def edit
  end

  def create
    review = Review.new(review_params)
    review.save
    redirect_to review_path(review.id)
  end


  private
  def review_params
    params.require(:review).permit(:title, :body)
  end

end
