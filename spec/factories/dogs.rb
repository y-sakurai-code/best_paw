FactoryBot.define do
  factory :dog do
    name { "ポチ" }
    breed { "トイプードル" }
    birthday { "2020-01-01" }
    size { 1 }
    gender { 0 }
    
    association :user

    trait :with_image do
      after(:build) do |dog|
        dog.image.attach(
          io: File.open(Rails.root.join('spec/fixtures/test_image.jpg')),
          filename: 'test_image.jpg',
          content_type: 'image/jpeg'
        )
      end
    end
  end
end