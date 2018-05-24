class ItemsController < ApplicationController
  before_action :card_confirm, only: %i[create destroy]
  def create
    @item = Item.new(item_params)
    @item.save ? flash[:notice] = '購入しました！' : flash[:error] = '購入できませんでした。'
    redirect_to event_path
  end

  def destroy
    @item = Item.find_by(item_params)
    @item.destroy ? flash[:notice] = 'キャンセルしました。' : flash[:error] = 'キャンセルに失敗しました。'
    redirect_to event_path
  end

  protected

  def item_params
    params.require(:item).permit(:name, :content, :price, :count, :event_id)
  end
end
