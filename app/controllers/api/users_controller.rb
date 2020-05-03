class Api::UsersController < ApplicationController

  def users_list
    @users = User.all.select(:id, :name, :icon, :mail)
    json_response(@users)
  end

  def insert_event_and_event_user
    # まずはイベントを登録
    # event_params
    # event = Event.new
    # event.day = Time.current
    # event.save
  end

  private

  def event_params
    params.require(:event).permit(:name, :day, :community_id, :description, { :user_ids=> [] } )
  end
end
