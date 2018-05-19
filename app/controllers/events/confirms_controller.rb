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
end
