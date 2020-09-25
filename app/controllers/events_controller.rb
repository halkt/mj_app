# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update]

  def index
    @events = if current_user.admin?
                Event.all.order(day: :desc)
              else
                Event.filter_user(current_user.id).order(day: :desc)
              end
  end

  # TODO: 閲覧権限があるかどうかチェックする必要あり
  def show
    @event_users = @event.users.order(:id)
    @game = Game.joins(:event).where(event_id: params[:id]).order(:created_at)
    @community_name = Community.find(@event.community_id).name
    game_ids = @game.pluck(:id)
    @gamedetails = GameDetail.where(game_id: game_ids).group_by_sum_score
  end

  def new
    @event = Event.new
    @event.event_users.build
    @communities = Community.affiliation_user(current_user.id)
    @users = User.affiliation_community(@communities.pluck(:id))
  end

  # TODO: 閲覧権限があるかどうかチェックする必要あり
  def edit
    @communities = Community.affiliation_user(current_user.id)
    @users = User.affiliation_community(@communities.pluck(:id))
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_url, notice: "対局「#{@event.name}」を登録しました。"
    else
      @communities = Community.affiliation_user(current_user.id)
      @users = User.affiliation_community(@communities.pluck(:id))
      render :new
    end
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(params[:id]), notice: "対局「#{@event.name}」を更新しました。"
    else
      @communities = Community.affiliation_user(current_user.id)
      @users = User.affiliation_community(@communities.pluck(:id))
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_url, notice: "対局「#{event.name}」を削除しました。"
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name,
                                  :day,
                                  :community_id,
                                  :description,
                                  { user_ids: [] })
  end
end
