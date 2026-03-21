require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'バリデーションのテスト' do
    let!(:genre) { build(:genre) }

    it "有効な内容であれば保存される" do
      expect(genre).to be_valid
    end

    it "nameが空欄だと保存できない" do
      genre.name = ""
      expect(genre).to_not be_valid
    end

    it "すでに存在するnameは登録できない" do
      create(:genre, name: "おもちゃ")
      duplicate_genre = build(:genre, name: "おもちゃ")
      expect(duplicate_genre).to_not be_valid
    end

    it "nameが21文字以上だと保存できない" do
      genre.name = "あ" * 21
      expect(genre).to_not be_valid
    end
  end
end