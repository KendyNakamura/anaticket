class PurchasesController < ApplicationController
  before_action :purchase_find, only: %i[destroy]
  before_action :payjp_api, only: %i[create destroy]

  def create
    @purchase = Purchase.new(purchase_params)
    return unless @purchase.save
    charge = Purchase.capture_charge(@purchase)
    @purchase.update(charge_id: charge.id)
    flash[:notice] = '購入が完了しました。決済はまだ行われません。'
    redirect_to event_path(@purchase.event)
  end

  def destroy
    Purchase.cansel_charge(@purchase) if Purchase.cansel_time(@purchase)
    Payjp::Charge.retrieve(@purchase.charge_id).refund
    @purchase.destroy ? flash[:notice] = 'キャンセルしました。' : flash[:error] = 'キャンセルに失敗しました。'
    redirect_to event_path(@purchase.event)
  end

  protected

  def payjp_api
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
  end

  def purchase_params
    params.require(:purchase).permit(:event_id, :user_id, :item_id, :process)
  end

  def purchase_find
    @purchase = Purchase.find_by(purchase_params)
  end
end
