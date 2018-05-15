class ItemsController < ApplicationController
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = '購入しました！'
    else
      flash[:error] = '購入できませんでした。'
    end
    redirect_to "/events/#{@item.event.event_url}"
  end

  def destroy
    @item = Item.find_by(item_params)
    if @item.destroy
      flash[:notice] = 'キャンセルしました。'
    else
      flash[:error] = 'キャンセルに失敗しました。'
    end
    redirect_to "/events/#{@item.event.event_url}"
  end

  protected

  def item_params
    params.require(:item).permit(:name, :content, :price, :count, :event_id)
  end
end
