class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    review.save
    redirect_to review_path(review.id)
  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    review = Review.find(params[:id])
    review.update(review_params)
    redirect_to review_path(review.id)
  end

  def destroy
    review = Review.find(params[:id])
    review.destroy(review_params)
    redirect_to reviews_path
  end


  private
  def review_params
    params.require(:review).permit(:title, :body)
  end

end
