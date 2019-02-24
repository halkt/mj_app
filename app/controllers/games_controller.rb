class GamesController < ApplicationController
  def index
    @games =Game.all
    @gamedetails = GameDetail.all
  end

  def new
    @event = Event.find(params[:event_id])
    @game =Game.new
    4.times { @game.game_detail.build }
    @user = User.joins(:event_users).where("event_id = ?", params[:event_id])

    # デフォルトで2つの住所入力欄を作成したい場合は次のようにする
    # @game.game_detail.build

  end

  def create
    @game = Game.create(game_params)
    if @game.save
      redirect_to event_path(params[:event_id]), notice: "保存成功"
    else
      redirect_to new_event_games_path(params[:event_id]), notice: "保存失敗"
    end
  end

  private

  def game_params
    params.require(:game).permit(:genten, :event_id, :kaeshiten, :horse_id, :tobi_rule, :yakitori_rule, :description, game_detail_attributes: [:id, :game_id, :user_id, :point, :rank, :tobi_flg, :yakitori_flg])
  end


end
