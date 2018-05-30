# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def line
    basic_action
  end

  def facebook
    basic_action
  end

  private

  def basic_action
    @omniauth = request.env['omniauth.auth']
    return unless @omniauth.present?
    @profile = User.where(auth_params).first
    @profile ||= current_user || User.create!(authuser_params)
    # if @profile
    #   sign_in(:user, @profile)
    # else
    #   @profile = current_user || User.create!(authuser_params)
    #   sign_in(:user, @profile)
    #   redirect_to(home_card_path) && return
    # end
    sign_in(:user, @profile)
    flash[:notice] = 'ログインしました!'
    redirect_to root_path
  end

  def auth_params
    {
      provider: @omniauth['provider'],
      uid: @omniauth['uid']
    }
  end

  def authuser_params
    {
      confirmed_at: Time.now,
      provider: @omniauth['provider'],
      uid: @omniauth['uid'],
      email: @omniauth['info']['email'] ? @omniauth['info']['email'] : "#{@omniauth.uid}@example.com",
      name: @omniauth['info']['name'],
      password: Devise.friendly_token[0, 20]
    }
  end

  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
