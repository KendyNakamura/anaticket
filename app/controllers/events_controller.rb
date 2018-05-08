class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'イベントを作成しました！'
    else
      flash[:danger] = 'イベントの作成に失敗しました。'
    end
    redirect_to('/')
  end

  protected

  def event_params
    params.require(:event).permit(:title, :content, :check, :password, :password_confirmation)
  end
end
