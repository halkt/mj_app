# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::HorsesController, type: :request do
  let!(:horse) { FactoryBot.create(:horse) }

  describe 'GET /admin/horses', :login do
    context '管理者の場合' do
      it '200が返ること' do
        get admin_horses_path
        expect(response).to have_http_status(200)
      end
    end

    context '管理者以外の場合' do
      let!(:user) { FactoryBot.create(:user, admin: false) }
      it '302が返ること' do
        get admin_horses_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /admin/horses/new', :login do
    it '200が返ること' do
      get new_admin_horse_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /admin/horses/:id/edit', :login do
    it '200が返ること' do
      get edit_admin_horse_path(horse.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE /admin/horses/:id', :login do
    it '302が返ること' do
      delete admin_horse_path(horse.id)
      expect(response).to have_http_status(302)
    end
  end
end
