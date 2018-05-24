require 'payjp'

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :card_confirm
  before_action :event_find, only: %i[show]

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

  def destroy; end

  protected

  def event_new
    @event = Event.new(event_params)
  end

  def payjp_api
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
  end

  def event_find
    @event = Event.find_by(event_url: params[:event_url])
    @item = Item.find_or_initialize_by(event_id: @event.id)
    @join = Join.new
    @joins = Join.where(event_id: @event.id)
    @purchase = Purchase.find_by(user_id: current_user.id, event_id: @event.id)
    @purchases = Purchase.where(event_id: @event.id)
  end
end
