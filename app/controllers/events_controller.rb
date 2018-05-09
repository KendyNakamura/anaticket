class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create confirm finish]

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(event_url: params[:event_url])
    @join = Join.new
    @joins = Join.where(event_id: @event.id)
  end

  def confirm
    @event = Event.new(event_params)
    render :new if @event.invalid?
  end

  def create
    @event = Event.new(event_params)
    @event.user_id = current_user.id
    if params[:back]
      render :new
    elsif @event.save
      flash[:notice] = 'イベントを作成しました！'
      redirect_to "/events/finish/#{@event.event_url}"
    else
      render :new
    end
  end

  def finish
    @event = Event.find_by(event_url: params[:event_url])
  end

  protected

  def event_params
    params.require(:event).permit(:title,
                                  :content,
                                  :max_persons,
                                  :check,
                                  :user_id,
                                  :start_date,
                                  :start_time,
                                  :password,
                                  :password_confirmation)
  end
end
