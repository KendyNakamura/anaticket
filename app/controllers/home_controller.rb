require 'payjp'

class HomeController < ApplicationController
  before_action :user_find, only: %i[show card create_card update_card update]
  before_action :pay_api, only: %i[card create_card update_card]
  before_action :customer_params, only: %i[card create_card update_card]
  protect_from_forgery except: %i[create_card update_card]
  def index
    @events = Event.order('created_at desc')
  end

  protected

  def user_params
    params.require(:user).permit(:name)
  end

  def user_find
    @user = User.find_by(user_url: params[:user_url])
  end

  def pay_api
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
  end

  def customer_params
    @customer = Payjp::Customer.retrieve(@user.card_token) unless current_user.card_token.nil?
  end
end
