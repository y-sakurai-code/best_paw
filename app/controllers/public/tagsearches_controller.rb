class Public::TagsearchesController < ApplicationController

  def search
    @model = Review
    @word = params[:content]
    @reviews = Review.where("category LIKE ?", "%#{@word}%").order(created_at: :desc)
    render "tagsearches/tagsearch"
  end
end
