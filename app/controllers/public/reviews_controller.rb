class Public::ReviewsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review.id)
    else
      render :new
    end
  end

  def index
    if params[:tag_name].present?
      @search_word = params[:tag_name]
      @reviews = Review.where('category LIKE ?', "%#{params[:tag_name]}%").order(created_at: :desc)
    else
      @reviews = Review.all.order(created_at: :desc)
      @search_word = nil
    end
  end

  def show
    @review = Review.find(params[:id])
    @review_comment = ReviewComment.new
    @review_comments = @review.review_comments
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      redirect_to review_path(@review.id)
    else
      @review = Review.find(params[:id])
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to users_mypage_path(current_user)
  end


  private
  def review_params
    params.require(:review).permit(:title, :body, :star, :category)
  end

  def is_matching_login_user
    @review = Review.find(params[:id])
    unless @review.user_id == current_user.id
      redirect_to reviews_path
    end
  end

end
