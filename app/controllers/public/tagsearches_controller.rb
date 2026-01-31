class TagsearchesController < ApplicationController

  def search
    @model = Review
    @word = params[:content]
    @reviews = Review.where("category LIKE?","%#{@word}%")
    render "tagsearches/tagsearch"
  end
end
