class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def card_confirm
    flash[:notice] = 'カード情報を登録してください'
    redirect_to home_card_path(current_user) if current_user.card_token.nil?
  end

  # override devise
  def after_sign_in_path_for(_resource)
    home_card_path(current_user) if current_user.card_token.nil?
    root_path(current_user)
  end

  def after_sign_out_path_for(_resource)
    new_user_session_path
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[name email password password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
    devise_parameter_sanitizer.permit(:account_update, keys: added_attrs)
    devise_parameter_sanitizer.permit(:sign_in, keys: added_attrs)
  end
end
