class PurchasesController < ApplicationController
  before_action :purchase_find, only: %i[destroy]

  def create
    @purchase = Purchase.new(purchase_params)
    return unless @purchase.save
    flash[:notice] = '購入が完了しました。決済はまだ行われません。'
    redirect_to event_path(@purchase.event)
  end

  def destroy
    price = (@purchase.item.price * 0.3 + 50).ceil
    if (@purchase.event.finish_time - Time.now).negative?
      Payjp::Charge.create(
        amount: price,
        customer: current_user.card_token,
        currency: 'jpy'
      )
    end
    @purchase.destroy ? flash[:notice] = 'キャンセルしました。' : flash[:error] = 'キャンセルに失敗しました。'
    redirect_to event_path(@purchase.event)
  end

  protected

  def purchase_params
    params.require(:purchase).permit(:event_id, :user_id, :item_id)
  end

  def purchase_find
    @purchase = Purchase.find_by(purchase_params)
  end
end
