class Admin::UsersController < ApplicationController
  before_action :require_admin

  def index
    @users = User.all.order(:name)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "ユーザー「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
    else
      redirect_to admin_users_url, notice: "#{@user.errors.messages[:base].join('。')}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :mail, :description, :admin, :password, :password_confirmation, :login_flg, :icon)
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
