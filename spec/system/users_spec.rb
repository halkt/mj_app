# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー管理機能' , type: :system do
  let(:user_a) do
    FactoryBot.create(:user,
                      name: '管理者',
                      mail: 'admin@example.com',
                      admin: true,
                      login_flg: true)
  end
  let(:user_b) do
    FactoryBot.create(:user,
                      name: '一般人',
                      mail: 'civil@example.com',
                      admin: false,
                      login_flg: true)
  end

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.mail
    fill_in 'パスワード', with: login_user.password
    click_button 'ログイン'
  end

  shared_examples_for '登録したユーザーが表示される' do
    it { expect(page).to have_content '管理者' }
  end

  describe '一覧表示機能' do
    context '管理者ユーザーがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit admin_users_path
      end

      it_behaves_like '登録したユーザーが表示される'
    end

    context '一般ユーザーがログインしているとき' do
      let(:login_user) { user_b }

      before do
        visit admin_users_path
      end

      it 'マイページにリダイレクトされる' do
        expect(current_path).to eq root_path
      end
    end
  end

  describe '詳細表示機能' do
    context '管理者ユーザーがログインしているとき' do
      let(:login_user) { user_a }

      before do
        visit admin_users_path(user_a)
      end

      it_behaves_like '登録したユーザーが表示される'
    end
  end

  describe '新規作成機能' do
    let(:login_user) { user_a }

    before do
      visit new_admin_user_path
      fill_in '名前', with: user_name
      fill_in 'メールアドレス', with: user_mail
      fill_in 'パスワード', with: user_password
      fill_in 'パスワード（確認）', with: user_password_confirm
      click_button '登録する'
    end

    context '新規作成画面でユーザー情報を正しく入力したとき' do
      let(:user_name) { 'テストくん' }
      let(:user_mail) { 'testXXX@example.com' }
      let(:user_password) { 'password' }
      let(:user_password_confirm) { 'password' }

      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: 'テストくん'
      end
    end
  end
end
