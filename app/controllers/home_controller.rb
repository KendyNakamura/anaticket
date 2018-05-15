require 'payjp'

class HomeController < ApplicationController
  before_action :user_find, only: %i[show card create_card delete_card update]
  def index
    @events = Event.order('created_at desc')
  end

  def show
    @events = Event.order('created_at desc')
  end

  def card
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
    @customer = Payjp::Customer.retrieve(@user.card_token)
    if @customer.default_card.present?
      @card = @customer.cards.retrieve(@customer.default_card)
    end
  end

  def create_card
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
    unless @user.card_token.present?
      customer = Payjp::Customer.create(card: params['token'], email: current_user.email)
      @user.card_token = customer.id
    else
      customer = Payjp::Customer.retrieve(@user.card_token)
      customer.cards.create(card: params['token'])
    end
    if @user.save
      flash[:notice] = "登録完了"
      redirect_to "/home/#{@user.user_url}/card"
    else
      flash[:notice] ="登録失敗"
      render :card
    end
  end

  def delete_card
    Payjp.api_key = 'sk_test_c20011eceeec8b5bb590fb98'
    @customer = Payjp::Customer.retrieve(@user.card_token)
    @card = @customer.cards.retrieve(@customer.default_card)
    @card.delete
    if @user.save
      flash[:notice] = "削除完了"
      redirect_to "/home/#{@user.user_url}/card"
    else
      flash[:notice] ="削除失敗"
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
end
