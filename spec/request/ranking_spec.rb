# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RankingsController, type: :request do
  let!(:game) { FactoryBot.create(:game) }

  describe 'GET /rankings/show', :login do
    it '200が返ること' do
      get rankings_show_path
      expect(response).to have_http_status(200)
    end
  end
end
