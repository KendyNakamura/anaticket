class Home::ProfilesController < HomeController
  def show
    @user = User.find_by(user_url: params[:user_url])
    @events = Event.order('created_at desc')
    @purchases = Purchase.where(user_id: current_user.id).order('created_at desc')
  end

  def update
    @user = User.find_by(id: current_user.id)
    @user.update(user_params) ? flash[:notice] = '保存しました。' : flash[:error] = '保存に失敗しました。'
    redirect_to home_profile_path
  end

  protected

  def user_params
    params.require(:user).permit(:name)
  end

  def user_find
    @user = User.find_by(user_url: params[:user_url])
  end
end
