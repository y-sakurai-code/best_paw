require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { create(:user) }
    let!(:genre) { create(:genre) }
    let!(:dog) { create(:dog, user: user) }
    let!(:review) { build(:review, user: user, genre: genre, dog_ids: [dog.id]) }

    it "有効な内容であれば保存される" do
      expect(review).to be_valid
    end

    it "紐付ける愛犬(dog_ids)が選択されていないと保存できない" do
      review.dogs = []
      expect(review).to_not be_valid
    end

    it "titleが空欄だと保存できない" do
      review.title = ""
      expect(review).to_not be_valid
    end

    it "bodyが空欄だと保存できない" do
      review.body = ""
      expect(review).to_not be_valid
    end

    it "item_nameが空欄だと保存できない" do
      review.item_name = ""
      expect(review).to_not be_valid
    end

    it "categoryが空欄だと保存できない" do
      review.category = ""
      expect(review).to_not be_valid
    end

    it "starが空欄だと保存できない" do
      review.star = nil
      expect(review).to_not be_valid
    end

    it "starが1未満（0など）だと保存できない" do
      review.star = 0
      expect(review).to_not be_valid
    end

    it "starが5より大きい（6など）だと保存できない" do
      review.star = 6
      expect(review).to_not be_valid
    end

    it "user_id（投稿者）がないと保存できない" do
      review.user = nil
      expect(review).to_not be_valid
    end

    it "genre_id（ジャンル）がないと保存できない" do
      review.genre = nil
      expect(review).to_not be_valid
    end
  end
end
