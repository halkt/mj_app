class HorsesController < ApplicationController
  def index
    @horses = Horse.all
  end

  def new
    @horse = Horse.new
  end

  def create
    horse = Horse.new(horse_params)
    horse.save!
    redirect_to horses_url, notice: "ウマ「#{horse.name}」を登録しました。"
  end

  def edit
    @horse = Horse.find(params[:id])
  end

  def update
    @horse = Horse.find(params[:id])
    @horse.update!(horse_params)
    redirect_to horses_url, notice: "ウマ「#{@horse.name}」を更新しました。"
  end

  def destroy
    horse = Horse.find(params[:id])
    horse.destroy
    redirect_to horses_url, notice: "ウマ「#{horse.name}」を削除しました。"
  end

  private

  def horse_params
    params.require(:horse).permit(:name, :point1, :point2)
  end

end
