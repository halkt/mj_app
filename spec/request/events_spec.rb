# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let!(:event) { FactoryBot.create(:event) }

  describe 'GET /events', :login do
    it '200が返ること' do
      get events_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/new', :login do
    it '200が返ること' do
      get new_event_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id/edit', :login do
    it '200が返ること' do
      get edit_event_path(event.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id', :login do
    it '200が返ること' do
      get event_path(event.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /events', :login do
    let!(:user) { FactoryBot.create(:user) }
    let!(:community) { FactoryBot.create(:community) }
    let(:params) do
      {
        event: event_params
      }
    end
    context '正常なPOSTパラメータの場合' do
      let!(:event_params) do
        {
          name: 'hogehoge',
          day: Time.current,
          community_id: community.id,
          user_ids: [user.id]
        }
      end
      it '302が返ること' do
        post events_path, params: params
        expect(response).to have_http_status(302)
        expect(user.events.count).to eq 1
      end
    end

    context '異常なPOSTパラメータの場合' do
      let!(:event_params) do
        {
          name: 'hogehoge',
          day: 'test',
          community_id: community.id,
          user_ids: [user.id]
        }
      end
      it '200が返ること' do
        post events_path, params: params
        expect(response).to have_http_status(200)
        expect(user.events.count).to eq 0
      end
    end
  end

  describe 'PUT /events', :login do
    let!(:user) { FactoryBot.create(:user) }
    let!(:community) { FactoryBot.create(:community) }
    let(:params) do
      {
        event: event_params
      }
    end
    context '正常なPOSTパラメータの場合' do
      let!(:event_params) do
        {
          name: 'hogehoge',
          day: Time.current,
          community_id: community.id,
          user_ids: [user.id]
        }
      end
      it '302が返ること' do
        put event_path(event.id), params: params
        expect(response).to have_http_status(302)
        expect(event.reload.name).to eq 'hogehoge'
      end
    end

    context '異常なPOSTパラメータの場合' do
      let!(:event_params) do
        {
          name: 'hogehoge',
          day: 'test',
          community_id: community.id,
          user_ids: [user.id]
        }
      end
      it '200が返ること' do
        put event_path(event.id), params: params
        expect(response).to have_http_status(200)
        expect(event.reload.name).to eq 'テスト大会1'
      end
    end
  end

  describe 'DELETE /events', :login do
    it '302が返ること' do
      delete event_path(event.id)
      expect(response).to have_http_status(302)
    end
  end
end
