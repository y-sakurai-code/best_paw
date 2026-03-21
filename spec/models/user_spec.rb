require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションのテスト' do
    let!(:user) { build(:user) }

    it "有効な内容であれば保存される" do
      expect(user).to be_valid
    end

    it "nameが空欄だと保存できない" do
      user.name = ""
      expect(user).to_not be_valid
    end

    it "emailが空欄だと保存できない" do
      user.email = ""
      expect(user).to_not be_valid
    end

    it "すでに存在するemailは登録できない" do
      create(:user, email: "overlap@example.com")
      another_user = build(:user, email: "overlap@example.com")
      expect(another_user).to_not be_valid
    end

    it "passwordが6文字未満だと保存できない" do
      user.password = "12345"
      user.password_confirmation = "12345"
      expect(user).to_not be_valid
    end
  end
end