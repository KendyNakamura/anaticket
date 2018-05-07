class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:new_event]

  def index
    @events = Event.all
  end

  def new_event
    @event = Event.find_by(id: params[:id])
  end
end
