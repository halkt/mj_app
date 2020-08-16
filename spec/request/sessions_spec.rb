# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'SessionsController', type: :request do
  describe 'GET /login' do
    it 'ログイン画面の表示に成功すること' do
      get '/login'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /login' do
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
      post '/login', params: params
      expect(response).to have_http_status(302)
    end
  end

  describe 'DELETE /logout' do
    before { post '/login', params: params }
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
      delete '/logout'
      expect(response).to have_http_status(302)
    end
  end
end
