class Events::PayController < EventsController
  protect_from_forgery except: ['create']
  before_action :event_find, only: %i[create]
  before_action :card_confirm, only: %i[create]
  before_action :payjp_api, only: %i[create]

  def create
    point = 0
    @purchases.each do |purchase|
      Payjp::Charge.create(amount: purchase.item.price, customer: purchase.user.card_token, currency: 'jpy')
      purchase.update(process: '1')
      point += (purchase.item.price / 1.1).ceil
    end
    current_user.point += point
    if current_user.save
      flash[:notice] = "決済が完了しました。 今回の獲得ポイント#{point}"
    else
      flash[:error] = "決済エラーが発生しました。\nお問い合わせください。"
    end
    redirect_to event_path
  end
end
