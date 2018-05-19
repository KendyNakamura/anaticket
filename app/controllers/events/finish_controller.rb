class Events::FinishController < EventsController
  before_action :authenticate_user!, only: %i[show]
  before_action :event_find, only: %i[show]
  def show; end

  def create
    @event = Event.new(event_params)
    @item = Item.find_by(event_id: @event.id)
    if params[:back]
      render :new
    elsif @event.save
      NotificationMailer.send_confirm_to_user(@event).deliver
      flash[:notice] = 'イベントを作成しました！'
      redirect_to events_finish_path(@event)
    else
      render :new
    end
  end
end
