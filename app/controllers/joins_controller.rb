class JoinsController < ApplicationController
  def create
    @join = Join.new(join_params)
    @join.save ? flash[:notice] = '参加しました！' : flash[:error] = '参加できませんでした。'
    redirect_to event_path(@join.event)
  end

  def destroy
    @join = Join.find_by(join_params)
    @join.destroy ? flash[:notice] = 'キャンセルしました。' : flash[:error] = 'キャンセルに失敗しました。'
    redirect_to event_path(@join.event)
  end

  protected

  def join_params
    params.require(:join).permit(:event_id, :user_id)
  end
end
