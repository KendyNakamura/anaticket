class Events::PasswordsController < EventsController
  before_action :event_find, only: %i[show create]

  def show; end

  def create
    if @event.authenticate(session_params[:value])
      flash[:notice] = '認証しました'
      session[:event_id] = @event.id
      redirect_to "/events/#{@event.event_url}"
    else
      flash[:notice] = 'パスワードが違います'
      render :password
    end
  end
end
