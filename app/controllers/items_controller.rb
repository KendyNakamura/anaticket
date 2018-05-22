class ItemsController < ApplicationController
  before_action :card_confirm, only: %i[create destroy]
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = '購入しました！'
    else
      flash[:error] = '購入できませんでした。'
    end
    redirect_to event_path
  end

  def destroy
    @item = Item.find_by(item_params)
    if @item.destroy
      flash[:notice] = 'キャンセルしました。'
    else
      flash[:error] = 'キャンセルに失敗しました。'
    end
    redirect_to event_path
  end

  protected

  def item_params
    params.require(:item).permit(:name, :content, :price, :count, :event_id)
  end
end
