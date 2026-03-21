FactoryBot.define do
  factory :favorite_comment do
    association :user
    association :review_comment
  end
end