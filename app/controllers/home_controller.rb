require 'payjp'

class HomeController < ApplicationController
  before_action :user_find, only: %i[show card create_card update_card delete_card update]
  before_action :pay_api, only: %i[card create_card update_card delete_card]
  before_action :customer_params, only: %i[card create_card update_card delete_card]
  def index
    @events = Event.order('created_at desc')
  end

  def show
    @events = Event.order('created_at desc')
  end

  def card
    return unless @customer.default_card.present?
    @card = @customer.cards.retrieve(@customer.default_card)
  end

  def create_card
    if @customer.cards.create(card: params['token'])
      flash[:notice] = '保存しました。'
      redirect_to "/home/#{@user.user_url}/card"
    else
      flash[:notice] = '保存に失敗しました。'
      render :card
    end
  end

  def update_card
    customer = Payjp::Customer.create(card: params['token'], email: current_user.email)
    @user.card_token = customer.id
    if @user.save
      flash[:notice] = '保存しました。'
      redirect_to "/home/#{@user.user_url}/card"
    else
      flash[:notice] = '保存に失敗しました。'
      render :card
    end
  end

  def delete_card
    @card = @customer.cards.retrieve(@customer.default_card)
    @card.delete
    if @user.save
      flash[:notice] = '削除完了'
      redirect_to "/home/#{@user.user_url}/card"
    else
      flash[:notice] = '削除失敗'
      render :card
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = '保存しました。'
    else
      flash[:error] = '保存に失敗しました。'
    end
    redirect_to("/home/#{@user.user_url}")
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
    @customer = Payjp::Customer.retrieve(@user.card_token)
  end
end
