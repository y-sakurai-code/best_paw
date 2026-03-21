class Public::ReviewsController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    if @review.save
      redirect_to review_path(@review.id), notice: 'レビューを投稿しました'
    else
      render :new
    end
  end

  def index
    @dog_images = Rails.cache.fetch('dog_images_daily', expires_in: 24.hours) do
      uri = URI.parse("https://api.thedogapi.com/v1/images/search?limit=5&size=small")
      request = Net::HTTP::Get.new(uri)
      request["x-api-key"] = ENV['DOG_API_KEY']

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.code == '200'
        JSON.parse(response.body)
      else
        []
      end
    end

    if params[:tag_name].present?
      @search_word = params[:tag_name]
      @reviews = Review.kept.joins(:user).merge(User.kept).where('category LIKE ?', "%#{params[:tag_name]}%").order(created_at: :desc)
    else
      @reviews = Review.kept.joins(:user).merge(User.kept).order(created_at: :desc)
      @search_word = nil
    end
    @reviews = @reviews.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @review = Review.kept.find(params[:id])
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
    redirect_to users_mypage_path
  end


  private
  def review_params
    params.require(:review).permit(:item_name, :genre_id, :title, :body, :star, :category, dog_ids: [])
  end

  def is_matching_login_user
    @review = Review.find(params[:id])
    unless @review.user_id == current_user.id
      redirect_to reviews_path
    end
  end

end
