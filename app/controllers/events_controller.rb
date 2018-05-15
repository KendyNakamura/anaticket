class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new show create confirm finish]
  before_action :event_new, only: %i[create confirm]

  def new
    @event = Event.new
    @event.joins.build
  end

  def show
    @event = Event.find_by(event_url: params[:event_url])
    @join = Join.new
    @joins = Join.where(event_id: @event.id)
    return unless @event.check == '1' \
    && session[:event_id] != @event.id \
    && @event.user.id != current_user.id
    render :password
  end

  def password
    @event = Event.find_by(event_url: params[:event_url])
  end

  def authenticate
    @event = Event.find_by(event_url: params[:event_url])
    if @event.authenticate(session_params[:value])
      flash[:notice] = '認証しました'
      session[:event_id] = @event.id
      redirect_to "/events/#{@event.event_url}"
    else
      flash[:notice] = 'パスワードが違います'
      render :password
    end
  end

  def confirm
    render :new if @event.invalid?
  end

  def create
    @event.user_id = current_user.id
    if params[:back]
      render :new
    elsif @event.save
      NotificationMailer.send_confirm_to_user(@event).deliver
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
                                  :password_confirmation,
                                  joins_attributes: %i[user_id event_id])
  end

  def session_params
    params.require(:event).permit(:value)
  end

  def event_new
    @event = Event.new(event_params)
  end
end
