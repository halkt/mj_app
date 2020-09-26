# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GamesController, type: :request do
  let!(:event) { FactoryBot.create(:event) }
  let!(:game) { FactoryBot.create(:game, event: event) }
  let!(:horse) { Horse.first }

  describe 'GET /events/:event_id/games/new', :login do
    it '200が返ること' do
      get new_event_game_path(event.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:event_id/games/:id/edit', :login do
    it '200が返ること' do
      get edit_event_game_path(event.id, game.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /events/:event_id/games/:id', :login do
    it '200が返ること' do
      get event_game_path(event.id, game.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /events/:event_id/games', :login do
    let(:params) do
      {
        game: game_params
      }
    end
    let!(:game_detail_params_1) do
      {
        user_id: FactoryBot.create(:user).id,
        point: 30_000
      }
    end
    let!(:game_detail_params_2) do
      {
        user_id: FactoryBot.create(:user).id,
        point: 26_000
      }
    end
    let!(:game_detail_params_3) do
      {
        user_id: FactoryBot.create(:user).id,
        point: 24_000
      }
    end
    let!(:game_detail_params_4) do
      {
        user_id: FactoryBot.create(:user).id,
        point: 20_000
      }
    end

    context '正常な値の場合' do
      let!(:game_params) do
        {
          genten: 25_000,
          event_id: event.id,
          kaeshiten: 30_000,
          horse_id: horse.id,
          description: 'test_game',
          game_detail_attributes: [
            game_detail_params_1,
            game_detail_params_2,
            game_detail_params_3,
            game_detail_params_4
          ]
        }
      end
      it '302が返ること' do
        post event_games_path(event.id), params: params
        expect(response).to have_http_status(302)
        expect(Game.find_by(description: 'test_game').game_detail.size).to eq 4
      end
    end

    context '異常な値の場合' do
      let!(:game_params) do
        {
          genten: 'invalid',
          event_id: event.id,
          kaeshiten: 30_000,
          horse_id: horse.id,
          description: 'test_game',
          game_detail_attributes: [
            game_detail_params_1,
            game_detail_params_2,
            game_detail_params_3,
            game_detail_params_4
          ]
        }
      end
      it '200が返ること' do
        post event_games_path(event.id), params: params
        expect(response).to have_http_status(200)
        expect(Game.find_by(description: 'test_game')).to eq nil
      end
    end
  end

  describe 'GET /events/:event_id/games/:id', :login do
    it '200が返ること' do
      get event_game_path(event.id, game.id)
      expect(response).to have_http_status(200)
    end
  end

  describe 'PUT /events/:event_id/games/:id', :login do
    let(:params) do
      {
        game: game_params
      }
    end
    let!(:game_detail_params_1) do
      {
        id: game.game_detail.first.id,
        user_id: game.game_detail.first.user.id,
        point: 50_000
      }
    end
    let!(:game_detail_params_2) do
      {
        id: game.game_detail.second.id,
        user_id: game.game_detail.second.user.id,
        point: 30_000
      }
    end
    let!(:game_detail_params_3) do
      {
        id: game.game_detail.third.id,
        user_id: game.game_detail.third.user.id,
        point: 15_000
      }
    end
    let!(:game_detail_params_4) do
      {
        id: game.game_detail.fourth.id,
        user_id: game.game_detail.fourth.user.id,
        point: 5_000
      }
    end

    context '正常な値の場合' do
      let!(:game_params) do
        {
          genten: 25_000,
          event_id: event.id,
          kaeshiten: 30_000,
          horse_id: horse.id,
          description: 'update_game',
          game_detail_attributes: [
            game_detail_params_1,
            game_detail_params_2,
            game_detail_params_3,
            game_detail_params_4
          ]
        }
      end
      it '302が返ること' do
        put event_game_path(event.id, game.id), params: params
        expect(response).to have_http_status(302)
        expect(Game.find_by(description: 'update_game').game_detail.size).to eq 4
      end
    end

    context '異常な値の場合' do
      let!(:game_params) do
        {
          genten: 'invalid',
          event_id: event.id,
          kaeshiten: 30_000,
          horse_id: horse.id,
          description: 'update_game',
          game_detail_attributes: [
            game_detail_params_1,
            game_detail_params_2,
            game_detail_params_3,
            game_detail_params_4
          ]
        }
      end
      it '200が返ること' do
        put event_game_path(event.id, game.id), params: params
        expect(response).to have_http_status(200)
        expect(Game.find_by(description: 'update_game')).to eq nil
      end
    end
  end

  describe 'DELETE /events/:event_id/games/:id', :login do
    context '正常な値の場合' do
      it '302が返ること' do
        delete event_game_path(event.id, game.id)
        expect(response).to have_http_status(302)
      end
    end

    context '異常な値の場合' do
      let!(:another_event) { FactoryBot.create(:event) }
      it '302が返ること' do
        delete event_game_path(another_event.id, game.id)
        expect(response).to have_http_status(302)
      end
    end
  end
end
