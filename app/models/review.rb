class Review < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true
  validates :star, presence: true
  validates :category, presence: true


  belongs_to :user
  has_many :review_comments, dependent: :destroy
  has_many :favorite_reviews, dependent: :destroy
  has_many :dog_reviews, dependent: :destroy
  has_many :dogs, through: :dog_reviews

  def self.looks(search, word)
    if search == "perfect_match"
      @review = Review.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @review = Review.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @review = Review.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @review = Review.where("title LIKE?","%#{word}%")
    else
      @review = Review.all
    end
  end

  def favorite_reviews_by?(user)
    favorite_reviews.exists?(user_id: user.id)
  end
end
