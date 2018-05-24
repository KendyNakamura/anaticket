class Events::PasswordController < EventsController
  before_action :event_find, only: %i[show]

  def show; end

  def create
    if @event.authenticate(session_params[:value])
      flash[:notice] = '認証しました'
      session[:event_id] = @event.id
      redirect_to event_path(@event)
    else
      flash[:notice] = 'パスワードが違います'
      render :show
    end
  end

  private

  def session_params
    params.require(:event).permit(:value)
  end
end
