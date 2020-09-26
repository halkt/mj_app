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

  describe 'POST /admin/horses', :login do
    let(:params) do
      {
        horse: horse_params
      }
    end
    let(:horse_params) do
      {
        name: 'horse_name',
        point1: 10_000,
        point2: point2
      }
    end
    context '正常な値の場合' do
      let!(:point2) { 5_000 }
      it '302が返ること' do
        post admin_horses_path, params: params
        expect(response).to have_http_status(302)
      end
    end

    context '異常な値の場合' do
      let!(:point2) { 20_000 }
      it '200が返ること' do
        post admin_horses_path, params: params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'PUT /admin/horses/:id', :login do
    let!(:user) { FactoryBot.create(:user, admin: true) }
    let(:params) do
      {
        horse: horse_params
      }
    end
    let(:horse_params) do
      {
        name: 'horse_name',
        point1: 10_000,
        point2: point2
      }
    end
    context '正常な値の場合' do
      let!(:point2) { 5_000 }
      it '302が返ること' do
        put admin_horse_path(horse.id), params: params
        expect(response).to have_http_status(302)
      end
    end

    context '異常な値の場合' do
      let!(:point2) { 20_000 }
      it '200が返ること' do
        put admin_horse_path(horse.id), params: params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /admin/horses/:id', :login do
    it '302が返ること' do
      delete admin_horse_path(horse.id)
      expect(response).to have_http_status(302)
    end
  end
end
