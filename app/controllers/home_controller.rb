class HomeController < ApplicationController
  def index
    @events = Event.order('created_at desc')
  end

  def show
    @user = User.find_by(user_url: params[:user_url])
    @events = Event.order('created_at desc')
    @joins = Join.where(event_id: @event.id)
  end

  def update
    @user = User.find_by(user_url: params[:user_url])
    if @user.update(user_params)
      flash[:notice] = '保存しました。'
    else
      flash[:error] = '保存に失敗しました。'
    end
    redirect_to("/home/#{@user.user_url}")
  end

  protected

  def user_params
    params.require(:user).permit(:name)
  end
end
