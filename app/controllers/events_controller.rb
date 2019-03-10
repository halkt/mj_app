class EventsController < ApplicationController
  def index
    @events = Event.all.order(:id)
  end

  def show
    @event = Event.find(params[:id])
    @event_users = EventUser.where("event_id = ?", params[:id]).order(:id)
    @game = Game.joins(:event).where("event_id = ?" , params[:id]).order(:created_at)
  end

  def new
    @event = Event.new
    @users = User.all.order(:name, :id)
    @event.event_users.build
  end

  def edit
    @event = Event.find(params[:id])
  end

  def create
    event = Event.new(event_params)

    if event.save
      redirect_to events_url, notice: "対局「#{event.name}」を登録しました。"
    else
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(params[:id]), notice: "対局「#{@event.name}」を更新しました。"
    else
      render :edit
    end
  end

  def destroy
    event = Event.find(params[:id])
    event.destroy
    redirect_to events_url, notice: "対局「#{event.name}」を削除しました。"
  end

  private

  def event_params
    #params.require(:event).permit(:name, :day, :description, event_users_attributes: [:id, :user_id, :event_id])
    params.require(:event).permit(:name, :day, :description, { :user_ids=> [] } )
  end
end
