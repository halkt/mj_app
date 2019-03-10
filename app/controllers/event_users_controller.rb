class EventUsersController < ApplicationController
  def index
    @users = User.all
    @eventusers = EventUser.where("event_id = ?", params[:event_id])
  end

  def edit
    @users = User.all
    @event_users = EventUser.where("event_id = ?", params[:event_id])
  end

  def new
    @eventuser = EventUser.new
  end

  def create
    f = params[:event_users_attributes]
    f.map do |u_id|
      event_user = EventUser.new(user_id: u_id ,event_id: params[:event_id])
      if event_user.save
        flash[u_id] = "登録・・・！"
      else
        
      end
    end
    redirect_to event_path(params[:event_id]), notice: "選択したユーザーを登録しました。"
  end

  def create_all
    checked_data = params[:event_users_attributes] # ここでcheckされたデータを受け取っています。
    if checked_data.nil?
      redirect_to event_path(params[:event_id]), notice: "ユーザーが選択されていません"
    else
      EventUser.new(checked_data)
      redirect_to event_path(params[:event_id]), notice: "選択したユーザーを削除しました。"
    end
  end


  def update
    @hoge = Hoge.new(hoge_params)
  end

  def destroy
    f = params[:event_users_attributes]
    f.map do |u_id|
      event_user = EventUser.find_by(user_id: u_id, event_id: params[:event_id])
      event_user.destroy
    end
    redirect_to event_path(params[:id]), notice: "ユーザーを削除しました。"
    # redirect_to event_path(params[:id]): "ユーザー「#{user.name}」を削除しました。"
    # redirect_to users_url, notice: "ユーザー「#{user.name}」を削除しました。"
  end

  def destroy_all
    checked_data = params[:event_users_attributes] # ここでcheckされたデータを受け取っています。
    if checked_data.nil?
      redirect_to event_path(params[:event_id]), notice: "ユーザーが選択されていません"
    else
      EventUser.destroy(checked_data)
      redirect_to event_path(params[:event_id]), notice: "選択したユーザーを削除しました。"
    end
  end

  def order
    # params[:ussers] => user.idの配列が入ってる
    @users.find(params[:users]) # チェックしたユーザーが全て取得可能
    # orderの処理
  end


  private
  def eventuser_params
    params.require(:event_user).permit(:user_id, :event_id)
  end
end
