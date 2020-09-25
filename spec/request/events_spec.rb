# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :request do
  let!(:event) { FactoryBot.create(:event) }

  describe 'GET /events', :login do
    it 'ログイン画面の表示に成功すること' do
      get events_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/new', :login do
    it 'ログイン画面の表示に成功すること' do
      get new_event_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id/edit', :login do
    it 'ログイン画面の表示に成功すること' do
      get edit_event_path(event.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:id', :login do
    it 'ログイン画面の表示に成功すること' do
      get event_path(event.id)
      expect(response).to have_http_status(200)
    end
  end
end
