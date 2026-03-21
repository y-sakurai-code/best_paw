FactoryBot.define do
  factory :favorite_review do
    association :user
    association :review
  end
end