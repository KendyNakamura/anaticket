class Events::PasswordController < EventsController
  before_action :event_find, only: %i[show]

  def show; end

  def create
    @event = Event.find_by(event_url: params[:event_url])
    if @event.authenticate(session_params[:value])
      flash[:notice] = '認証しました'
      session[:event_id] = @event.id
      redirect_to event_path(@event)
    else
      flash[:notice] = 'パスワードが違います'
      render :show
    end
  end

  def session_params
    params.require(:event).permit(:value)
  end
end
