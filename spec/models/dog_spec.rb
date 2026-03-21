require 'rails_helper'

RSpec.describe Dog, type: :model do
  describe 'バリデーションのテスト' do
    let!(:dog) { build(:dog) }

    it "有効な内容であれば保存される" do
      expect(dog).to be_valid
    end

    it "nameが空欄だと保存できない" do
      dog.name = ""
      expect(dog).to_not be_valid
    end

    it "breed（犬種）が空欄だと保存できない" do
      dog.breed = ""
      expect(dog).to_not be_valid
    end

    it "birthdayが空欄だと保存できない" do
      dog.birthday = nil
      expect(dog).to_not be_valid
    end

    it "sizeが空欄だと保存できない" do
      dog.size = ""
      expect(dog).to_not be_valid
    end

    it "genderが空欄だと保存できない" do
      dog.gender = ""
      expect(dog).to_not be_valid
    end

    it "user_idがないと保存できない" do
      dog.user = nil
      expect(dog).to_not be_valid
    end
  end
end