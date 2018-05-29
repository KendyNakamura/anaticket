class Events::FinishController < EventsController
  before_action :authenticate_user!, only: %i[show]
  before_action :join_find, only: %i[show]
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

  private

  def event_params
    params.require(:event).permit(:title,
                                  :content,
                                  :max_persons,
                                  :check,
                                  :user_id,
                                  :event_url,
                                  :start_time,
                                  :finish_time,
                                  :free,
                                  :password,
                                  :password_confirmation,
                                  items_attributes: %i[name content price count event_id])
  end
end
