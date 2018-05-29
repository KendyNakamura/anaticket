require 'payjp'

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :card_confirm
  before_action :join_find, only: %i[show destroy]
  before_action :event_find, only: %i[show destroy]

  def new
    @event = Event.new
    @event.items.build
  end

  def show
    return unless @event.check == '1' \
    && session[:event_id] != @event.id \
    && @event.user.id != current_user.id
    render template: 'events/password/show'
  end

  def destroy
    @purchases.each do |purchase|
      Payjp::Charge.retrieve(purchase.charge_id).refund
      NotificationMailer.send_event_cansel(purchase).deliver if purchase.destroy
    end
    @event.destroy
    flash[:notice] = 'イベントをキャンセルしました。'
    redirect_to root_path
  end

  protected

  def event_new
    @event = Event.new(event_params)
  end

  def payjp_api
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
  end

  def event_find
    @event = Event.find_by(event_url: params[:event_url])
    @item = Item.find_by(event_id: @event.id)
    @purchase = Purchase.find_by(user_id: current_user.id, event_id: @event.id)
    @purchases = Purchase.where(event_id: @event.id)
  end

  def join_find
    @join = Join.new
    # @joins = Join.where(event_id: @event.id)
  end
end
