# frozen_string_literal: true

class GamesController < ApplicationController
  before_action :set_event_users, only: %i[new edit create update]
  before_action :set_game, only: %i[edit update show destroy]
  def new
    @event = Event.find(params[:event_id])
    @game = Game.new
    4.times { @game.game_detail.build }
  end

  def edit
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    @game = Game.create(game_params)
    if @game.save
      redirect_to event_path(params[:event_id]), notice: '対局スコアの登録に成功しました'
    else
      render 'games/new', id: params[:event_id]
    end
  end

  def update
    @event = Event.find(params[:event_id])
    if @game.update(game_params)
      redirect_to event_path(params[:event_id]), notice: '対局スコアの更新に成功しました'
    else
      render 'games/edit', event_id: params[:event_id], id: params[:id]
    end
  end

  def show; end

  def destroy
    param = @game.event.id
    if @game.destroy
      redirect_to event_path(param), notice: '成績の削除しました。'
    else
      redirect_to event_path(params[:event_id]),
                  notice: @game.errors.messages[:base].join('。').to_s
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def set_event_users
    @user = User.joins(:event_users)
                .where('event_id = ?', params[:event_id])
                .order(:name)
  end

  def game_params
    params.require(:game)
          .permit(:genten,
                  :event_id,
                  :kaeshiten,
                  :horse_id,
                  :description,
                  game_detail_attributes: %i[id game_id user_id point rank])
  end
end
