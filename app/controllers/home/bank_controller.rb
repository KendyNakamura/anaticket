class Home::BankController < HomeController
  # before_action :user_find, only: %i[show create update]
  protect_from_forgery except: %i[create update]
  def new
    @bank = Bank.find_or_initialize_by(user_id: current_user.id)
  end

  def create
    @bank = Bank.new(bank_params)
    if @bank.create(bank_params)
      NotificationMailer.send_confirm_to_bank(current_user).deliver
      current_user.update(point: 0)
      flash[:notice] = '振り込みを確定しました。'
    else
      flash[:error] = '振り込みに失敗しました。'
    end
    redirect_to home_profile_path(current_user)
  end

  def update
    @bank = Bank.find_or_initialize_by(user_id: current_user.id)
    if @bank.update(bank_params)
      NotificationMailer.send_confirm_to_bank(current_user).deliver
      NotificationMailer.send_receive_to_bank(current_user).deliver
      current_user.update(point: 0)
      flash[:notice] = '振り込みを確定しました。'
    else
      flash[:error] = '振り込みに失敗しました。'
    end
    redirect_to home_profile_path(current_user)
  end

  protected

  def bank_params
    params.require(:bank).permit(:bank_name,
                                 :branch_name,
                                 :deposit_type,
                                 :bank_num,
                                 :account_holder,
                                 :user_id)
  end
end
