FactoryBot.define do
  factory :review_comment do
    comment { "非常に参考になるレビューですね！ありがとうございます。" }
    
    association :user
    association :review
  end
end