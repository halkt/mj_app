# frozen_string_literal: true

class Admin::HorsesController < ApplicationController
  before_action :require_admin
  before_action :set_horse, only: %i[edit update destroy]

  def index
    @horses = Horse.all.order(:point1, :point2)
  end

  def new
    @horse = Horse.new
  end

  def create
    @horse = Horse.new(horse_params)
    if @horse.save
      message = get_create_notice_message(@horse.name)
      redirect_to admin_horses_path(@horse), notice: message
    else
      render :new
    end
  end

  def edit; end

  def update
    if @horse.update(horse_params)
      message = get_update_notice_message(@horse.name)
      redirect_to admin_horses_path(@horse), notice: message
    else
      render :edit
    end
  end

  def destroy
    @horse.destroy
    message = get_delete_notice_message(@horse.name)
    redirect_to admin_horses_path(@horse), notice: message
  end

  private

  def set_horse
    @horse = Horse.find(params[:id])
  end

  def horse_params
    params.require(:horse).permit(:name, :point1, :point2)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def get_create_notice_message(horse_name)
    "ウマ「#{horse_name}」を登録しました。"
  end

  def get_update_notice_message(horse_name)
    "ウマ「#{horse_name}」を更新しました。"
  end

  def get_delete_notice_message(horse_name)
    "ウマ「#{horse_name}」を削除しました。"
  end
end
