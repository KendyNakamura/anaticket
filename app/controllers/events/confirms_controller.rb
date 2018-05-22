class Events::ConfirmsController < EventsController
  before_action :authenticate_user!, only: %i[show create]
  before_action :event_find, only: %i[show]
  def show
    render template: 'events/new' if @event.invalid?
  end

  def create
    @event = Event.new(event_params)
    render :show
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
