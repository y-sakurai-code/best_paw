FactoryBot.define do
  factory :genre do
    sequence(:name) { |n| "Genre-#{n}" } # 名前をユニークにする
  end
end