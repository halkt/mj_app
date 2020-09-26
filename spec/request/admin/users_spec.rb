# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::UsersController, type: :request do
  let!(:user) do
    FactoryBot.create(:user, admin: true, login_flg: true)
  end

  describe 'GET /admin/users/:id/edit', :login do
    it '200が返ること' do
      get edit_admin_user_path(user.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /admin/users/:id', :login do
    let(:params) do
      {
        user: user_params
      }
    end
    let(:user_params) do
      {
        name: user_name,
        mail: 'hogehoge@example.com',
        description: 'test',
        password: 'password',
        password_confirmation: 'password',
        authority: authority
      }
    end
    context '正常な値の場合' do
      let!(:user_name) { SecureRandom.alphanumeric(50) }

      context 'authorityがadminの場合' do
        let!(:authority) { 'admin' }
        it '302が返ること' do
          put admin_user_path(user.id), params: params
          expect(response).to have_http_status(302)
        end
      end

      context 'authorityがloginの場合' do
        let!(:authority) { 'login' }
        it '302が返ること' do
          put admin_user_path(user.id), params: params
          expect(response).to have_http_status(302)
        end
      end
    end

    context '異常な値の場合' do
      let!(:user_name) { SecureRandom.alphanumeric(51) }
      let!(:authority) { 'other' }
      it '200が返ること' do
        put admin_user_path(user.id), params: params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /admin/users/:id', :login do
    it '302が返ること' do
      delete admin_user_path(user.id)
      expect(response).to have_http_status(302)
    end
  end
end
