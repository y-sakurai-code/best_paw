require 'rails_helper'

RSpec.describe '[STEP1] ユーザログイン前のテスト', type: :system do
  before do
    driven_by :rack_test
  end
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'ログインリンクが表示される' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end
      it '新規登録リンクが表示される' do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end
    end
  end

  describe 'アバウト画面のテスト' do
    before do
      visit about_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/homes/about'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしていない場合' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'Best Paw(ロゴ)リンクが表示される' do
        expect(page).to have_link 'Best Paw', href: root_path
      end
      it 'Aboutリンクが表示される' do
        expect(page).to have_link 'About', href: about_path
      end
      it '新規登録リンクが表示される' do
        expect(page).to have_link '新規登録', href: new_user_registration_path
      end
      it 'ログインリンクが表示される' do
        expect(page).to have_link 'ログイン', href: new_user_session_path
      end
    end
  end

  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_user_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/sign_up'
      end
      it '「新規ユーザー登録」と表示される' do
        expect(page).to have_content '新規ユーザー登録'
      end
      it 'ユーザーネームフォームが表示される' do
        expect(page).to have_field 'user[name]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'user[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'user[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'user[password_confirmation]'
      end
      it 'アカウントを作成するボタンが表示される' do
        expect(page).to have_button 'アカウントを作成する'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button 'アカウントを作成する' }.to change(User, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、マイページになっている' do
        click_button 'アカウントを作成する'
        expect(current_path).to eq "/users/mypage"
      end
    end
  end

  describe 'ユーザログイン' do
    let!(:user) { create(:user) }

    before do
      visit new_user_session_path
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ユーザマイページになっている' do
        expect(current_path).to eq '/users/mypage'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/users/sign_in'
      end
    end
  end

  describe 'ユーザログアウトのテスト' do
    let!(:user) { create(:user) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
      click_link 'ログアウト'
    end

    context 'ログアウト機能のテスト' do
      it 'ログアウト後のリダイレクト先が、Aboutページになっている' do
        expect(current_path).to eq '/homes/about'
      end
    end
  end
end