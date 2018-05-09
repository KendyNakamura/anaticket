class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by(id: params[:id])
    @join = Join.new
    @joins = Join.where(event_id: @event.id)
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    if @event.save
      flash[:notice] = 'イベントを作成しました！'
    else
      flash[:danger] = 'イベントの作成に失敗しました。'
    end
    redirect_to('/')
  end

  protected

  def event_params
    params.require(:event).permit(:title,
                                  :content,
                                  :max_persons,
                                  :check,
                                  :start_date,
                                  :start_time,
                                  :password,
                                  :password_confirmation)
  end
end
