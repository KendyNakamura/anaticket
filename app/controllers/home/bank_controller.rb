class Home::BankController < HomeController
  before_action :bank_find, only: %i[new update]
  protect_from_forgery except: %i[create update]
  def new; end

  def create
    @bank = Bank.new(bank_params)
    if @bank.create(bank_params)
      @bank.bank_update(@bank)
      flash[:notice] = '振り込みを確定しました。'
    else
      flash[:error] = '振り込みに失敗しました。'
    end
    redirect_to home_profile_path(current_user)
  end

  def update
    if @bank.update(bank_params)
      @bank.bank_update(@bank)
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

  def bank_find
    @bank = Bank.find_or_initialize_by(user_id: current_user.id)
  end
end
