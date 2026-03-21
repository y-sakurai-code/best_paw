require 'rails_helper'

RSpec.describe FavoriteComment, type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { create(:user) }
    let!(:comment) { create(:review_comment) }
    let!(:favorite_comment) { build(:favorite_comment, user: user, review_comment: comment) }

    it "有効な内容であれば保存される" do
      expect(favorite_comment).to be_valid
    end

    it "user_idがないと保存できない" do
      favorite_comment.user = nil
      expect(favorite_comment).to_not be_valid
    end

    it "review_comment_idがないと保存できない" do
      favorite_comment.review_comment = nil
      expect(favorite_comment).to_not be_valid
    end

    it "すでに同じコメントをいいねしている場合は保存できない" do
      create(:favorite_comment, user: user, review_comment: comment)
      duplicate = build(:favorite_comment, user: user, review_comment: comment)
      expect(duplicate).to_not be_valid
    end
  end
end