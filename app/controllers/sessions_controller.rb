# frozen_string_literal: true

class SessionsController < ApplicationController
  # ログインしていなくても利用可能
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(mail: session_params[:mail])
    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました。'
    else
      redirect_to login_path, notice: '【ログイン失敗】メールアドレスかパスワードに誤りがないか確認してください。'
    end
  end

  def destroy
    reset_session
    redirect_to root_path, notice: 'ログアウトしました。'
  end

  private

  def session_params
    params.require(:session).permit(:mail, :password)
  end
end
