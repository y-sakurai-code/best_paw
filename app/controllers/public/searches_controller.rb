class Public::SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Dog"
      @reviews = Review.joins(user: :dogs).where("dogs.breed LIKE ?", "%#{@word}%").distinct.page(params[:page]).per(10)
    else
      @reviews = Review.where("title LIKE ? OR body LIKE ?", "%#{@word}%", "%#{@word}%").page(params[:page]).per(10)
    end
  end
end
