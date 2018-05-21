class Events::PaysController < EventsController
  before_action :event_find, only: %i[create]
  before_action :card_confirm, only: %i[create]
  before_action :payjp_api, only: %i[create]
  before_action :purchases_where, only: %i[create]

  def create
    @purchases.each do |purchase|
      Payjp::Charge.create(amount: purchase.item.price, customer: purchase.user.card_token, currency: 'jpy')
      purchase.update(process: '1')
      current_user.point += (purchase.item.price / 1.1).ceil
    end
    flash[:notice] = "決済が完了しました。\n現在の獲得ポイント#{current_user.point}"
    redirect_to events_pay_path
  end
end

private

def purchases_where
  @purchases = Purchase.where(event_id: @event.id)
end
