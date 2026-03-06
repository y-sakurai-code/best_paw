class ReviewComment < ApplicationRecord

  belongs_to :user
  belongs_to :review
  has_many :favorite_comments, dependent: :destroy

  
  validates :comment, presence: true
  

  def favorite_comments_by?(user)
    favorite_comments.exists?(user_id: user.id)
  end

  def create_notification_favorite_comment!(current_user)
    temp = Notification.where(["visitor_id = ? AND visited_id = ? AND subject_id = ? AND subject_type = ? AND action = ?", current_user.id, user_id, id, 'ReviewComment', 'favorite_comment'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        subject_id: id,
        subject_type: 'ReviewComment',
        visited_id: user_id,
        action: 'favorite_comment'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

end
