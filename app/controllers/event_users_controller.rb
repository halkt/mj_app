class EventUsersController < ApplicationController
  def index
    @event_users = EventUser.where("event_id = ?", params[:event_id])
  end

  def create
  end

  def edit
    @users = User.all
    @event_users = EventUser.where("event_id = ?", params[:event_id])
  end

  def new
    @event = Event.find(params[:event_id])
  end
end
