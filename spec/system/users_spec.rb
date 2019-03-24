require 'rails_helper'

describe 'ユーザー管理機能' , type: :system do
  let(:user_a) { FactoryBot.create(:user, name: '管理者', mail: 'admin@example.com', admin: true ) }
  let(:user_b) { FactoryBot.create(:user, name: '一般人', mail: 'civil@example.com', admin: false ) }

  before do
    visit login_path
    fill_in 'メールアドレス', with: login_user.mail
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
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

end
