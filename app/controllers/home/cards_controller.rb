class Home::CardsController < HomeController
  before_action :user_find, only: %i[show create update]
  before_action :pay_api, only: %i[show create update]
  before_action :customer_params, only: %i[show update]
  protect_from_forgery except: %i[create update]
  def show
    return if current_user.card_token.nil?
    return unless @customer.default_card.present?
    @card = @customer.cards.retrieve(@customer.default_card)
  end

  def create
    customer = Payjp::Customer.create(card: params['token'], email: current_user.email)
    return unless current_user.update(card_token: customer.id)
    flash[:notice] = '保存しました。'
    redirect_to home_card_path(current_user)
  end

  def update
    @card = @customer.cards.retrieve(@customer.default_card)
    return unless @card.delete && @customer.cards.create(card: params['token'])
    flash[:notice] = '更新完了'
    redirect_to home_card_path(current_user)
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
