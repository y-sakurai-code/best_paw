FactoryBot.define do
  factory :review do
    after(:build) do |review|
      review.dogs << build(:dog, user: review.user) if review.dogs.blank?
    end

    sequence(:title) { |n| "レビュータイトル#{n}" }
    body { "愛犬がとても喜んで遊んでいます。作りもしっかりしています。" }
    star { 0.5 }
    category { "おもちゃ" }
    item_name { "特製ドッグボーン" }
    
    association :user
    association :genre

  end
end