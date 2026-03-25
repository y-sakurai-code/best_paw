require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let!(:user) { create(:user, name: "my-name", email: "my-email@example.com") }
  let!(:other_user) { create(:user, name: "other-name", email: "other-email@example.com") }
  let!(:dog) { create(:dog, user: user, name: "わんこ") }
  let!(:other_dog) { create(:dog, user: other_user, name: "ポチ") }
  let!(:genre) { create(:genre, name: "おもちゃ") }
  let!(:review) { create(:review, user: user, genre: genre, dogs: [dog]) }
  let!(:other_review) { create(:review, user: other_user, genre: genre, dogs: [other_dog], title: "とても良い商品です") }

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
      it 'レビュー投稿を押すと、レビュー投稿に遷移する' do
        click_link 'レビュー投稿'
        is_expected.to eq '/reviews/new'
      end
      it 'ログアウトリンクを押すと、Aboutページが表示される' do
        click_link 'ログアウト'
        is_expected.to eq '/homes/about'
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

  describe '権限のテスト: 他人の投稿編集へのアクセス' do
    it '他人の投稿編集画面に遷移しようとすると、投稿一覧にリダイレクトされる' do
      visit edit_review_path(other_review)
      expect(current_path).to eq '/reviews'
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
      it 'リダイレクト先がマイページになっている' do
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

  describe 'マイページ（自分のユーザ詳細画面）のテスト' do
    before do
      visit users_mypage_path
    end

    context 'サイドバー（家族情報）の表示確認' do
      it 'ログインユーザーの名前が表示される' do
        expect(page).to have_content user.name
      end

      it '登録している愛犬の名前と年齢が表示される' do
        expect(page).to have_content dog.name
        expect(page).to have_content dog.age
      end

      it '「ユーザー設定」リンクが表示される' do
        expect(page).to have_link 'ユーザー設定', href: user_path(user)
      end

      it '「愛犬の編集」リンクが表示される' do
        expect(page).to have_link "#{dog.name}の編集", href: edit_dog_path(dog)
      end

      it '「新しい家族を登録」リンクが表示される' do
        expect(page).to have_link '新しい家族を登録', href: new_dog_path
      end

      it '「思い出箱」リンクが表示される' do
        expect(page).to have_link '思い出箱（虹の橋）', href: memorial_dogs_path
      end
    end

    context '投稿一覧部分の表示確認' do
      it '「（ユーザー名）さんの投稿一覧」と見出しが表示される' do
        expect(page).to have_content "#{user.name} さんの投稿一覧"
      end

      it '自分の投稿（レビュー）が表示されている' do
        expect(page).to have_content review.title
      end

      it '他人の投稿は表示されない' do
        expect(page).not_to have_content other_review.title
      end
    end

    context '投稿がない場合の表示確認' do
      before do
        user.reviews.destroy_all
        visit users_mypage_path
      end

      it '「まだレビューを投稿していません。」と表示される' do
        expect(page).to have_content 'まだレビューを投稿していません。'
      end

      it '「レビューを投稿する」ボタンが表示される' do
        expect(page).to have_link 'レビューを投稿する', href: new_review_path
      end
    end
  end

  describe '自分の投稿の管理テスト' do
    let!(:my_review) { create(:review, user: user, dogs: [dog], title: "元のタイトル", body: "元の本文", star: 3.0) }
    let!(:genre_snack) { Genre.find_or_create_by(name: "おやつ") }
    let!(:genre_toy) { Genre.find_or_create_by(name: "おもちゃ") }

    before do
      my_review.update(genre_id: genre_snack.id)
      visit edit_review_path(my_review)
    end

    it 'タイトルの更新に成功するか' do
      fill_in 'review[title]', with: '更新後のタイトル'
      click_button '更新する'
      expect(current_path).to eq review_path(my_review)
      expect(page).to have_content '更新後のタイトル'
    end

    it '本文の更新に成功するか' do
      fill_in 'review[body]', with: '新しい本文の内容です'
      click_button '更新する'
      expect(page).to have_content '新しい本文の内容です'
    end

    it '評価（星）が変更できないことを確認する' do
      expect(my_review.star).to eq 3.0
      click_button '更新する'
      my_review.reload
      expect(my_review.star).to eq 3.0
    end

    it 'ジャンルを「おやつ」から「おもちゃ」に変更できるか' do
      select 'おもちゃ', from: 'review[genre_id]'
      click_button '更新する'
      expect(page).to have_content 'おもちゃ'
      expect(page).not_to have_content 'おやつ'
    end

    it '自分の投稿を削除できるか' do
      visit users_mypage_path
      click_link '削除', href: review_path(my_review)
      expect(current_path).to include users_mypage_path
      expect(page).not_to have_content '元のタイトル'
    end
  end

  describe 'ユーザ情報編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_user_path(user)
      end
      it '「ユーザー情報の編集」と表示される' do
        expect(page).to have_content 'ユーザー情報の編集'
      end
      it 'ユーザーネーム編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'メールアドレス編集フォームに自分のアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '新しいパスワードフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it '「変更を保存する」ボタンが表示される' do
        expect(page).to have_button '変更を保存する'
      end
      it '「マイページに戻る」リンクが表示される' do
        expect(page).to have_link 'マイページに戻る', href: users_mypage_path
      end
      it '「退会手続きへ」リンクが表示される' do
        expect(page).to have_link '退会手続きへ'
      end
    end

    context '更新成功のテスト' do
      before do
        @old_name = user.name
        @old_email = user.email
        fill_in 'user[name]', with: 'updated-name'
        fill_in 'user[email]', with: 'updated@example.com'
        fill_in 'user[password]', with: user.password
        click_button '変更を保存する'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).to eq 'updated-name'
        expect(user.reload.name).not_to eq @old_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).to eq 'updated@example.com'
        expect(user.reload.email).not_to eq @old_email
      end
      it 'リダイレクト先が、ユーザー詳細ページになっている' do
        expect(current_path).to eq user_path(user)
      end
    end
  end

  describe 'dog新規登録のテスト', js: true do
    before do
      visit new_dog_path
    end

    it '新しい家族を正しく登録できるか' do
      fill_in 'dog[name]', with: 'チョコ'
      fill_in 'dog[breed]', with: 'ゴールデンレトリバー'
      fill_in 'dog[birthday]', with: '2020-01-01'
      select '大型', from: 'dog[size]'
      choose 'gender_male'

      click_button '新しく登録する'

      expect(current_path).to include users_mypage_path
      expect(page).to have_content 'チョコ'
    end

    it '入力漏れがある場合にエラーが表示されるか' do
      fill_in 'dog[name]', with: ''
      click_button '新しく登録する'
      expect(page).to have_content "Name can't be blank"
    end
  end

  describe '愛犬情報の編集・削除テスト' do
    let!(:dog) { create(:dog, user: user, name: "編集前わんこ", breed: "チワワ", birthday: "2020-01-01", size: "小型", gender: "female") }

    before do
      visit edit_dog_path(dog)
    end

    it '画像の更新に成功するか' do
      image_path = Rails.root.join('spec/fixtures/test_dog.jpg')
      attach_file 'dog[dog_image]', image_path
      click_button '更新する'
      dog.reload
      expect(dog.dog_image).to be_attached
    end

    it '名前の更新に成功するか' do
      fill_in 'dog[name]', with: '新しい名前'
      click_button '更新する'
      expect(current_path).to include users_mypage_path
      expect(page).to have_content '新しい名前'
    end

    it '犬種の更新に成功するか' do
      fill_in 'dog[breed]', with: 'トイプードル'
      click_button '更新する'
      dog.reload
      expect(dog.breed).to eq 'トイプードル'
    end

    it '誕生日の更新に成功するか' do
      fill_in 'dog[birthday]', with: '2022-12-25'
      click_button '更新する'
      dog.reload
      expect(dog.birthday.to_s).to eq '2022-12-25'
    end

    it 'サイズの更新に成功するか' do
      select '超小型', from: 'dog[size]'
      click_button '更新する'
      dog.reload
      expect(dog.size).to eq '超小型'
    end

    it '性別の更新に成功するか' do
      choose 'gender_male'
      click_button '更新する'
      dog.reload
      expect(dog.gender).to eq 'male'
    end

    it '「思い出箱」へ移動（アーカイブ）できるか' do
      click_link '思い出箱へ移動'
      expect(page).to have_content '思い出箱に移動しました。'
    end

    it 'データを完全に削除できるか' do
      click_link 'データを完全に削除'
      expect(current_path).to include users_mypage_path
      expect(page).not_to have_content '編集前わんこ'
    end
  end
end