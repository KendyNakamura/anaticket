class JoinsController < ApplicationController
  def create
    @join = Join.new(join_params)
    if @join.save
      flash[:notice] = '参加しました！'
    else
      flash[:error] = '参加できませんでした。'
    end
    redirect_to "/events/#{@join.event.id}"
  end

  def destroy
    @join = Join.find_by(join_params)
    if @join.destroy
      flash[:notice] = 'キャンセルしました。'
    else
      flash[:error] = 'キャンセルに失敗しました。'
    end
    redirect_to "/events/#{@join.event.id}"
  end

  protected

  def join_params
    params.require(:join).permit(:event_id, :user_id)
  end
end
