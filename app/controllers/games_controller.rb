class GamesController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @game =Game.new
    4.times { @game.game_detail.build }
    @user = User.joins(:event_users).where("event_id = ?", params[:event_id]).order(:name)
  end

  def edit
    @event = Event.find(params[:event_id])
    @game = Game.find(params[:id])
    @user = User.joins(:event_users).where("event_id = ?", params[:event_id]).order(:name)
  end

  def create
    @game = Game.create(game_params)
    if @game.save
      redirect_to event_path(params[:event_id]), notice: "対局スコアの登録に成功しました"
    else
      flash.now[:alert] = "対局スコアの登録に失敗しました"
      render :action => :edit
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(update_game_params)
      redirect_to event_path(params[:event_id]), notice: "対局スコアの更新に成功しました"
    else
      flash.now[:alert] = "対局スコアの更新に失敗しました"
      render :action => :new
    end
  end

  private

  def game_params
    params.require(:game).permit(:genten, :event_id, :kaeshiten, :horse_id, :description, game_detail_attributes: [:game_id, :user_id, :point, :rank, :id])
  end

  def update_game_params
    params.require(:game).permit(:genten, :event_id, :kaeshiten, :horse_id, :description, game_detail_attributes: [:id, :game_id, :user_id, :point, :rank])
  end

end
