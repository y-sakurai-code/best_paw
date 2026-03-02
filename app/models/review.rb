class Review < ApplicationRecord
  include Discard::Model

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

  def create_notification_comment!(current_user, review_comment_id)
  
    notification = current_user.active_notifications.new(
      review_id: id,
      review_comment_id: review_comment_id,
      visited_id: user_id,
      action: 'comment'
    )

    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_favorite_reviews!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and review_id = ? and action = ? ", current_user.id, user_id, id, 'favorite_reviews'])
  
    if temp.blank?
      notification = current_user.active_notifications.new(
        review_id: id,
        visited_id: user_id,
        action: 'favorite_reviews'
      )

      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def favorite_reviews_by?(user)
    favorite_reviews.exists?(user_id: user.id)
  end
end
