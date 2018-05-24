class PurchasesController < ApplicationController
  before_action :purchase_find, only: %i[destroy]

  def create
    @purchase = Purchase.new(purchase_params)
    return unless @purchase.save
    charge = @purchase.capture_charge(@purchase)
    @purchase.update(charge_id: charge.id)
    flash[:notice] = '購入が完了しました。決済はまだ行われません。'
    redirect_to event_path(@purchase.event)
  end

  def destroy
    @purchase.cansel_charge(@purchase) if (@purchase.event.start_time - (Time.now + 1.day)).negative?
    Payjp::Charge.retrieve(@purchase.charge_id).refund
    @purchase.destroy ? flash[:notice] = 'キャンセルしました。' : flash[:error] = 'キャンセルに失敗しました。'
    redirect_to event_path(@purchase.event)
  end

  protected

  def purchase_params
    params.require(:purchase).permit(:event_id, :user_id, :item_id, :process)
  end

  def purchase_find
    @purchase = Purchase.find_by(purchase_params)
  end
end
