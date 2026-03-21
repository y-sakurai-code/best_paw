require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'バリデーションのテスト' do
    let!(:visitor) { create(:user) }
    let!(:visited) { create(:user) }
    let!(:review)  { create(:review) }
    let!(:notification) { build(:notification, visitor: visitor, visited: visited, subject: review) }

    it "有効な内容であれば保存される" do
      expect(notification).to be_valid
    end

    it "visitor_id（送り主）がないと保存できない" do
      notification.visitor = nil
      expect(notification).to_not be_valid
    end

    it "visited_id（宛先）がないと保存できない" do
      notification.visited = nil
      expect(notification).to_not be_valid
    end

    it "action（通知種別）がないと保存できない" do
      notification.action = ""
      expect(notification).to_not be_valid
    end
  end
end