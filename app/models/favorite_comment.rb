class FavoriteComment < ApplicationRecord

  belongs_to :user
  belongs_to :review_comment

  validates :user_id, uniqueness: {scope: :review_comment_id}

end
