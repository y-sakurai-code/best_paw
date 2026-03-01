class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include Discard::Model

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

  def withdraw
    update(email: "#{email}_deleted_#{Time.current.to_i}")
    discard
  end

  def restore
    new_email = self.email.sub(/_deleted_\d+$/, '')
    update(email: new_email)
    undiscard
  end

  def active_for_authentication?
    super && !discarded?
  end

  after_discard do
    reviews.discard_all
  end

  after_undiscard do
    reviews.undiscard_all
  end

end
