# frozen_string_literal: true

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
    @user.destroy
    redirect_to admin_users_url, notice: "ユーザー「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    set_authority_params
    params.require(:user).permit(:name,
                                 :mail,
                                 :description,
                                 :admin,
                                 :password,
                                 :password_confirmation,
                                 :login_flg,
                                 :icon)
  end

  # 権限用のパラメータをセットする
  def set_authority_params
    case params[:user][:authority]
    when 'admin'
      set_admin_and_login_parameter(true, true)
    when 'login'
      set_admin_and_login_parameter(false, true)
    else
      set_admin_and_login_parameter(false, false)
    end
  end

  def set_admin_and_login_parameter(admin, login)
    params[:user][:admin] = admin
    params[:user][:login_flg] = login
  end

  def require_admin
    redirect_to root_path unless current_user.admin?
  end
end
