class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:new_event]
  def new_event
  end
end
