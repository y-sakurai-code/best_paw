require 'rails_helper'

RSpec.describe FavoriteReview, type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { create(:user) }
    let!(:review) { create(:review) }
    let!(:favorite_review) { build(:favorite_review, user: user, review: review) }

    it "有効な内容であれば保存される" do
      expect(favorite_review).to be_valid
    end

    it "user_idがないと保存できない" do
      favorite_review.user = nil
      expect(favorite_review).to_not be_valid
    end

    it "review_idがないと保存できない" do
      favorite_review.review = nil
      expect(favorite_review).to_not be_valid
    end

    it "すでに同じレビューをいいねしている場合は保存できない" do
      create(:favorite_review, user: user, review: review)
      duplicate_favorite = build(:favorite_review, user: user, review: review)
      expect(duplicate_favorite).to_not be_valid
    end
  end
end