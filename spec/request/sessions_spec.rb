# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  describe 'GET /login' do
    before { get '/login' }
    it 'ログイン画面の表示に成功すること' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /login' do
    before { post '/login', params: params }
    let!(:user) { FactoryBot.create(:user) }
    context 'メールアドレスとパスワードが一致する場合' do
      let!(:notice_message) { 'ログインしました。' }
      let!(:params) do
        {
          session: {
            mail: user.mail,
            password: 'password'
          }
        }
      end
      it 'ログイン画面の表示に成功すること' do
        expect(response).to have_http_status(302)
        expect(response.request.flash.notice).to eq notice_message
      end
    end
    context 'メールアドレスとパスワードが一致しない場合' do
      let!(:notice_message) { '【ログイン失敗】メールアドレスかパスワードに誤りがないか確認してください。' }
      let!(:params) do
        {
          session: {
            mail: user.mail,
            password: 'hogehoge'
          }
        }
      end
      it 'ログインに失敗すること' do
        expect(response).to have_http_status(302)
        expect(response.request.flash.notice).to eq notice_message
      end
    end
  end

  describe 'DELETE /logout' do
    before do
      post '/login', params: params
      delete '/logout'
    end
    let!(:notice_message) { 'ログアウトしました。' }
    let!(:user) { FactoryBot.create(:user) }
    let!(:params) do
      {
        session: {
          mail: user.mail,
          password: 'password'
        }
      }
    end
    it 'ログイン画面の表示に成功すること' do
      expect(response).to have_http_status(302)
      expect(response.request.flash.notice).to eq notice_message
    end
  end
end
