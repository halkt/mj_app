class HorsesController < ApplicationController
  def index
    @horses = Horse.all.order(:point1, :point2)
  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.new(horse_params)
    if @horse.save
      redirect_to horses_url, notice: "ウマ「#{@horse.name}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @horse = Horse.find(params[:id])
  end

  def update
    @horse = Horse.find(params[:id])
    if @horse.update(horse_params)
      redirect_to horses_url, notice: "ウマ「#{@horse.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    horse = Horse.find(params[:id])
    if horse.destroy
      redirect_to horses_url, notice: "ウマ「#{horse.name}」を削除しました。"
    else
      redirect_to horses_url, notice: "#{horse.errors.messages[:base].join('。')}"
    end
  end

  private

  def horse_params
    params.require(:horse).permit(:name, :point1, :point2)
  end

end
