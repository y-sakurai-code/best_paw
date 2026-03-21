require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let!(:user) { create(:user, name: "my-name", email: "my-email@example.com") }
  let!(:dog) { create(:dog, user: user, name: "わんこ") }
  let!(:genre) { create(:genre, name: "おもちゃ") }
  let!(:other_user) { create(:user, name: "other-name", email: "other-email@example.com") }
  let!(:review) { create(:review, user: user) }
  let!(:other_review) { create(:review, user: other_user) }

  before do
    driven_by :rack_test
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it 'Best Pawを押すと、投稿一覧画面に遷移する' do
        click_link 'Best Paw'
        is_expected.to eq '/reviews'
      end
      it 'Aboutを押すと、Aboutに遷移する' do
        click_link 'About'
        is_expected.to eq '/homes/about'
      end
      it 'マイページを押すと、自分のユーザ詳細画面に遷移する' do
        click_link 'マイページ'
        is_expected.to eq '/users/mypage'
      end
      it 'レビュー投稿を押すと、Aboutに遷移する' do
        click_link 'レビュー投稿'
        is_expected.to eq '/reviews/new'
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit reviews_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/reviews'
      end
      it '自分と他人の投稿タイトルのリンク先が正しい' do
        expect(page).to have_link review.title, href: review_path(review)
        expect(page).to have_link other_review.title, href: review_path(other_review)
      end
      it '自分と他人のレビュー本文が表示される' do
        expect(page).to have_content review.body
        expect(page).to have_content other_review.body
      end
      it '自分の投稿に編集・削除リンクが表示され、リンク先が正しい' do
        expect(page).to have_link href: edit_review_path(review)
        expect(page).to have_link href: review_path(review)
      end
      it '他人の投稿には編集・削除リンクが表示されない' do
        expect(page).not_to have_link href: edit_review_path(other_review)
      end
    end

    context '投稿成功のテスト' do
      before do
        visit new_review_path
        find('label', text: dog.name).click
        fill_in 'review[item_name]', with: 'テスト商品'
        select 'おもちゃ', from: 'review[genre_id]'
        fill_in 'review[title]', with: Faker::Lorem.characters(number: 5)
        fill_in 'review[category]', with: Faker::Lorem.characters(number: 5)
        fill_in 'review[body]', with: Faker::Lorem.characters(number: 20)
        find('#review_star', visible: false).set(3.5)
      end

      it '自分の新しいレビューが正しく保存される' do
        expect { click_button 'レビューを投稿する' }.to change(user.reviews, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button 'レビューを投稿する'
        expect(current_path).to eq '/reviews/' + Review.last.id.to_s
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit review_path(review)
    end

    context '表示内容の確認' do
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_review_path(review)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: review_path(review)
      end
    end

    context '削除リンクのテスト' do
      it '正しく削除される' do
        expect { click_link '削除' }.to change(Review, :count).by(-1)
      end
      it 'リダイレクト先が投稿一覧になっている' do
        click_link '削除'
        expect(current_path).to eq '/users/mypage'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_review_path(review)
    end

    context '編集成功のテスト' do
      before do
        @old_title = review.title
        fill_in 'review[title]', with: '更新後のタイトル'
        click_button '内容を更新する'
      end

      it 'titleが正しく更新される' do
        expect(review.reload.title).to eq '更新後のタイトル'
        expect(review.reload.title).not_to eq @old_title
      end
    end
  end
end