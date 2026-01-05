class ReviewsController < ApplicationController

  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    review.save
    redirect_to "/"
  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  def edit
  end


  private
  def review_params
    params.require(:review).permit(:title, :body)
  end

end
