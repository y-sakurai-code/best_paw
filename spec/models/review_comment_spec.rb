require 'rails_helper'

RSpec.describe ReviewComment, type: :model do
  describe 'バリデーションのテスト' do
    let!(:review_comment) { build(:review_comment) }

    it "有効な内容であれば保存される" do
      expect(review_comment).to be_valid
    end

    it "commentが空欄だと保存できない" do
      review_comment.comment = ""
      expect(review_comment).to_not be_valid
    end

    it "user_idがないと保存できない" do
      review_comment.user = nil
      expect(review_comment).to_not be_valid
    end

    it "review_idがないと保存できない" do
      review_comment.review = nil
      expect(review_comment).to_not be_valid
    end

    it "commentが200文字以上だと保存できない" do
      review_comment.comment = "あ" * 201
      expect(review_comment).to_not be_valid
    end
  end
end