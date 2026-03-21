FactoryBot.define do
  factory :notification do
    association :visitor, factory: :user
    association :visited, factory: :user
    association :subject, factory: :review
    
    action { "favorite" }
    checked { false }
  end
end