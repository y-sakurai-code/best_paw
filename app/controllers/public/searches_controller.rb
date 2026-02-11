class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Dog"
      @reviews = Review.joins(user: :dogs).where("dogs.breed LIKE ?", "%#{@word}%").distinct
    else
      @reviews = Review.where("title LIKE ? OR body LIKE ?", "%#{@word}%", "%#{@word}%")
    end
  end
end
