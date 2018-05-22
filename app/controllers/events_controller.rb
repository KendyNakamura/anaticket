require 'payjp'

class EventsController < ApplicationController
  before_action :authenticate_user!, only: %i[new show destroy]
  before_action :event_find, only: %i[show]

  def new
    @event = Event.new
    @event.items.build
  end

  def show
    return unless @event.check == '1' \
    && session[:event_id] != @event.id \
    && @event.user.id != current_user.id
    render :password
  end

  def destroy; end

  protected

  def event_new
    @event = Event.new(event_params)
  end

  # def event_params
  #   params.require(:event).permit(:title,
  #                                 :content,
  #                                 :max_persons,
  #                                 :check,
  #                                 :user_id,
  #                                 :event_url,
  #                                 :start_time,
  #                                 :finish_time,
  #                                 :free,
  #                                 :password,
  #                                 :password_confirmation,
  #                                 items_attributes: %i[name content price count event_id])
  # end

  def payjp_api
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
  end

  def event_find
    @event = Event.find_by(event_url: params[:event_url])
    @item = Item.find_by(event_id: @event.id)
    @join = Join.new
    @joins = Join.where(event_id: @event.id)
    @purchase = Purchase.find_by(user_id: current_user.id, event_id: @event.id)
    @purchases = Purchase.where(event_id: @event.id)
  end
end
