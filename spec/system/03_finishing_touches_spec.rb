require 'rails_helper'

describe '[STEP3] 仕上げのテスト' do
  let!(:user) { create(:user) }
  let!(:dog) { create(:dog, user: user, name: "わんこ") }
  let!(:genre) { create(:genre, name: "おもちゃ") }
  let!(:other_user) { create(:user) }
  let!(:review) { create(:review, user: user) }
  let!(:other_review) { create(:review, user: other_user) }

  before do
    driven_by :rack_test
  end

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザログイン成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      is_expected.to have_content 'successfully'
    end

    it 'レビューの新規投稿成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      
      visit new_review_path
      find('label', text: dog.name).click
      fill_in 'review[item_name]', with: 'テスト商品'
      select genre.name, from: 'review[genre_id]'
      fill_in 'review[title]', with: 'サクセステスト'
      fill_in 'review[category]', with: Faker::Lorem.characters(number: 5)
      fill_in 'review[body]', with: 'メッセージが表示されるかテストします。'
      find('#review_star', visible: false).set(5)
      
      click_button 'レビューを投稿する'
      is_expected.to have_content 'レビューを投稿しました'
    end
  end

  describe '処理失敗時のバリデーションテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      visit new_review_path
    end

    context '投稿失敗: titleを空にする' do
      before do
        fill_in 'review[title]', with: ''
        click_button 'レビューを投稿する'
      end

      it '投稿が保存されない' do
        expect { click_button 'レビューを投稿する' }.not_to change(Review, :count)
      end

      it 'バリデーションエラーが表示される' do
        expect(page).to have_content 'エラーが発生しました'
        expect(page).to have_content "can't be blank"
      end
    end
  end

  describe 'アクセス制限のテスト' do
    subject { current_path }

    it 'ログインしていない場合、レビュー一覧には行けずログイン画面に遷移する' do
      visit reviews_path
      is_expected.to eq new_user_session_path
    end

    it '他人のレビュー編集画面には遷移できず、一覧（またはマイページ）にリダイレクトされる' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      
      visit edit_review_path(other_review)
      expect(current_path).to eq reviews_path 
    end
  end

  describe 'アイコンのテスト' do
    it 'TOPに肉球アイコンが表示されている' do
      visit root_path
      expect(page).to have_selector '.fa-solid.fa-paw'
    end
  end
end