class Events::PaysController < EventsController
  before_action :event_find, only: %i[create]
  before_action :card_confirm, only: %i[create]

  def create
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
    @purchases = Purchase.where(event_id: @event.id)
    @purchases.each do |purchase|
      Payjp::Charge.create(amount: purchase.item.price, customer: purchase.user.card_token, currency: 'jpy')
      purchase.update(process: '1')
    end
    flash[:notice] = '決済が完了しました。'
    redirect_to events_pay_path
  end
end
