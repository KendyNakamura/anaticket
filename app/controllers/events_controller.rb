require 'payjp'

class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new show create confirm finish]
  before_action :event_new, only: %i[create confirm]
  before_action :event_find, only: %i[show password authenticate finish purchase pay]
  before_action :card_confirm, only: %i[pay]

  def new
    @event = Event.new
    @event.items.build
  end

  def show
    @join = Join.new
    @joins = Join.where(event_id: @event.id)
    @purchase = Purchase.new
    @purchases = Purchase.where(event_id: @event.id)
    return unless @event.check == '1' \
    && session[:event_id] != @event.id \
    && @event.user.id != current_user.id
    render :password
  end

  def purchase
    @purchase = Purchase.new(purchase_params)
    return unless @purchase.save
    flash[:notice] = '購入が完了しました。決済はまだ行われません。'
    redirect_to "/events/#{@event.event_url}"
  end

  def pay
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
    @purchases = Purchase.where(event_id: @event.id)
    @purchases.each do |purchase|
      Payjp::Charge.create(
        amount: purchase.item.price,
        customer: purchase.user.card_token,
        currency: 'jpy'
      )
      purchase.update(process: '1')
    end
    flash[:notice] = '決済が完了しました。'
    redirect_to "/events/#{@event.event_url}"
  end

  def password; end

  def authenticate
    if @event.authenticate(session_params[:value])
      flash[:notice] = '認証しました'
      session[:event_id] = @event.id
      redirect_to "/events/#{@event.event_url}"
    else
      flash[:notice] = 'パスワードが違います'
      render :password
    end
  end

  def confirm
    render :new if @event.invalid?
  end

  def create
    if params[:back]
      render :new
    elsif @event.save
      NotificationMailer.send_confirm_to_user(@event).deliver
      flash[:notice] = 'イベントを作成しました！'
      redirect_to "/events/finish/#{@event.event_url}"
    else
      render :new
    end
  end

  def finish; end

  protected

  def event_params
    params.require(:event).permit(:title,
                                  :content,
                                  :max_persons,
                                  :check,
                                  :user_id,
                                  :start_time,
                                  :finish_time,
                                  :free,
                                  :password,
                                  :password_confirmation,
                                  items_attributes: %i[name content price count event_id])
  end

  def purchase_params
    params.require(:purchase).permit(:user_id, :event_id, :item_id, :process)
  end

  def card_confirm
    flash[:notice] = 'カード情報を登録してください'
    redirect_to "/home/#{current_user.user_url}/card" if current_user.card_token.nil?
  end

  def event_new
    @event = Event.new(event_params)
  end

  def event_find
    @event = Event.find_by(event_url: params[:event_url])
    @item = Item.find_by(event_id: @event.id)
  end
end
