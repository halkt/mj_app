require 'rails_helper'

describe 'ユーザー管理機能' , type: :system do
  describe '一覧表示機能' do
    before do
      FactoryBot.create(:user, name: '管理者', mail: 'admin@example.com', admin: true )
    end

    context '管理者ユーザーがログインしているとき' do
      before do
        visit login_path
        fill_in 'メールアドレス', with: 'admin@example.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザーが表示される' do
        visit admin_users_path
        expect(page).to have_content '管理者'
      end
    end
  end
end
