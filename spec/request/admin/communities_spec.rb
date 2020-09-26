# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::CommunitiesController, type: :request do
  let!(:community) { FactoryBot.create(:community) }

  describe '#require_admin', :login do
    it '200が返ること' do
      get admin_communities_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /admin/communities', :login do
    context '管理者の場合' do
      it '200が返ること' do
        get admin_communities_path
        expect(response).to have_http_status(200)
      end
    end

    context '管理者以外の場合' do
      let!(:user) { FactoryBot.create(:user, admin: false) }
      it '302が返ること' do
        get admin_communities_path
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'GET /admin/communities/new', :login do
    it '200が返ること' do
      get new_admin_community_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /admin/communities/:id', :login do
    it '200が返ること' do
      get admin_community_path(community.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /admin/communities/:id/edit', :login do
    it '200が返ること' do
      get edit_admin_community_path(community.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /admin/communities', :login do
    subject { Community.where(name: community_name).count }
    let!(:user) { FactoryBot.create(:user, admin: true) }
    let(:params) do
      {
        community: community_params
      }
    end
    let(:community_params) do
      {
        name: community_name,
        description: 'test',
        user_ids: [user.id]
      }
    end
    context '正常な値の場合' do
      let!(:community_name) { SecureRandom.alphanumeric(50) }
      it '302が返ること' do
        post admin_communities_path, params: params
        expect(response).to have_http_status(302)
        is_expected.to eq 1
      end
    end

    context '異常な値の場合' do
      let!(:community_name) { SecureRandom.alphanumeric(51) }
      it '200が返ること' do
        post admin_communities_path, params: params
        expect(response).to have_http_status(200)
        is_expected.to eq 0
      end
    end
  end

  describe 'PUT /admin/communities/:id', :login do
    let!(:user) { FactoryBot.create(:user, admin: true) }
    let(:params) do
      {
        community: community_params
      }
    end
    let(:community_params) do
      {
        name: community_name,
        description: 'test',
        user_ids: [user.id]
      }
    end
    context '正常な値の場合' do
      let!(:community_name) { SecureRandom.alphanumeric(50) }
      it '302が返ること' do
        put admin_community_path(community.id), params: params
        expect(response).to have_http_status(302)
      end
    end

    context '異常な値の場合' do
      let!(:community_name) { SecureRandom.alphanumeric(51) }
      it '200が返ること' do
        put admin_community_path(community.id), params: params
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /admin/communities/:id', :login do
    it '302が返ること' do
      delete admin_community_path(community.id)
      expect(response).to have_http_status(302)
    end
  end
end
