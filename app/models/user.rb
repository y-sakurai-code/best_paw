class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :dogs, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :review_comments, dependent: :destroy
  has_many :favorite_reviews, dependent: :destroy
  has_many :favorite_comments, dependent: :destroy

  def self.looks(search, word)
    if search == "partial_match"
      @dog = Dog.where("name LIKE?","%#{word}%")
    else
      @dog = Dog.all
    end
  end
end
