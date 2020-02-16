class EventsController < ApplicationController
  def index
    if current_user.admin?
      @events = Event.all.order(day: "DESC")
    else
      @events = Event.filter_user(current_user.id).order(day: "DESC")
    end
  end

  def show
    @event = Event.find(params[:id])
    @event_users = @event.users.order(:id)
    @game = Game.joins(:event).where(event_id: params[:id]).order(:created_at)
    @community_name = Community.find(@event.community_id).name
  end

  def new
    @event = Event.new
    @event.event_users.build
    @communities = Community.affiliation_user(current_user.id)
    @users = User.affiliation_community(@communities.pluck(:id))
  end

  def edit
    @event = Event.find(params[:id])
    @communities = Community.affiliation_user(current_user.id)
    @users = User.affiliation_community(@communities.pluck(:id))
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      redirect_to events_url, notice: "対局「#{@event.name}」を登録しました。"
    else
      @communities = Community.affiliation_user(current_user.id)
      @users = User.affiliation_community(@communities.pluck(:id))
      render :new
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(params[:id]), notice: "対局「#{@event.name}」を更新しました。"
    else
      @communities = Community.affiliation_user(current_user.id)
      @users = User.affiliation_community(@communities.pluck(:id))
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
    params.require(:event).permit(:name, :day, :community_id, :description, { :user_ids=> [] } )
  end

end
