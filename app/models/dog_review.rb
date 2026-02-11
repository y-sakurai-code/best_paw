class DogReview < ApplicationRecord
  belongs_to :dog
  belongs_to :review
end
