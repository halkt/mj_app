class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
    @event_users = EventUser.where("event_id = ?", params[:id])
  end

  def new
    @event = Event.new
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    event = Event.new(event_params)
    event.save!
    redirect_to events_url, notice: "対局「#{event.name}」を登録しました。"
  end

  def update
    event = Event.find(params[:id])
    event.update!(event_params)
    redirect_to events_url, notice: "対局「#{event.name}」を更新しました。"
  end

  private

  def event_params
    params.require(:event).permit(:name, :day, :description)
  end
end
