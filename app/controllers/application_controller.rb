class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def card_confirm
    return unless current_user.card_token.nil?
    redirect_to home_card_path(current_user)
    flash[:notice] = 'カード情報を登録してください'
  end

  rescue_from SecurityError do |_exception|
    redirect_to root_url, notice: 'アクセス権限がありません。'
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

  def authenticate_admin_user!
    raise SecurityError unless current_user.try(:admin?)
  end
end
