# frozen_string_literal: true

class Admin::CommunitiesController < ApplicationController
  before_action :require_admin
  before_action :set_community, only: %i[show edit update destroy]

  def index
    @communities = Community.all.order(:id)
  end

  def show; end

  def new
    @community = Community.new
    @users = User.all.order(:id)
  end

  def edit
    @user = User.all.order(:id)
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      message = get_create_notice_message(@community.name)
      redirect_to admin_community_path(@community), notice: message
    else
      render :new
    end
  end

  def update
    if @community.update(community_params)
      message = get_update_notice_message(@community.name)
      redirect_to admin_community_path(@community), notice: message
    else
      render :new
    end
  end

  def destroy
    @community.destroy
    message = get_delete_notice_message(@community.name)
    redirect_to admin_communities_url, notice: message
  end

  private

  def set_community
    @community = Community.find(params[:id])
  end

  def community_params
    params.require(:community).permit(:name, :description, { user_ids: [] })
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end

  def get_create_notice_message(community_name)
    "コミュニティ「#{community_name}」を登録しました。"
  end

  def get_update_notice_message(community_name)
    "コミュニティ「#{community_name}」を更新しました。"
  end

  def get_delete_notice_message(community_name)
    "コミュニティ「#{community_name}」を削除しました。"
  end
end
