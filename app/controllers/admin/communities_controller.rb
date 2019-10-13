class Admin::CommunitiesController < ApplicationController
  before_action :require_admin

  def index
    @communities = Community.all.order(:id)
  end

  def show
    @community = Community.find(params[:id])
  end

  def new
    @community = Community.new
    @users = User.all.order(:id)
  end

  def edit
    @community = Community.find(params[:id])
    @users = User.all.order(:id)
  end

  def create
    @community = Community.new(community_params)
    if @community.save
      redirect_to admin_community_path(@community), notice: "コミュニティ「#{@community.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @community = Community.find(params[:id])

    if @community.update(community_params)
      redirect_to admin_community_path(@community), notice: "コミュニティ「#{@community.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @community = Community.find(params[:id])
    if @community.destroy
      redirect_to admin_communities_url, notice: "コミュニティ「#{@community.name}」を削除しました。"
    else
      redirect_to admin_communities_url, notice: "#{@community.errors.messages[:base].join('。')}"
    end
  end

  private

  def community_params
    params.require(:community).permit(:name, :description, { :user_ids=> [] })
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
