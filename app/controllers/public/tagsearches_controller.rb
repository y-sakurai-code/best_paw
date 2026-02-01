class Public::TagsearchesController < ApplicationController

  def search
    @model = Review
    @search_word = params[:tag_name]
    @reviews = Review.where("category LIKE ?", "%#{@search_word}%").order(created_at: :desc)
    render "public/reviews/index"
  end
end
