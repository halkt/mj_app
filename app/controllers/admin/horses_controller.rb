class Admin::HorsesController < ApplicationController
  before_action :require_admin

  def index
    @horses = Horse.all.order(:point1, :point2)
  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.new(horse_params)
    if @horse.save
      redirect_to admin_horses_path(@horse), notice: "ウマ「#{@horse.name}」を登録しました。"
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
      redirect_to admin_horses_path(@horse), notice: "ウマ「#{@horse.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    horse = Horse.find(params[:id])
    if horse.destroy
      redirect_to admin_horses_path(@horse), notice: "ウマ「#{horse.name}」を削除しました。"
    else
      redirect_to admin_horses_path(@horse), notice: "#{horse.errors.messages[:base].join('。')}"
    end
  end

  private

  def horse_params
    params.require(:horse).permit(:name, :point1, :point2)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
