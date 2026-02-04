class ReviewComment < ApplicationRecord

  belongs_to :user
  belongs_to :review
  has_many :favorite_comments, dependent: :destroy

  
  validates :comment, presence: true
  

  def favorite_comments_by?(user)
    favorite_comments.exists?(user_id: user.id)
  end

end
