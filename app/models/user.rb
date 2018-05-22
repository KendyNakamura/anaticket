# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string(255)
#  uid                    :string(255)
#  name                   :string(255)
#  user_url               :string(255)      not null
#  card_token             :string(255)
#  point                  :integer
#  deleted_at             :datetime
#

require 'payjp'

class User < ApplicationRecord
  # paranoia soft_delete
  acts_as_paranoid
  before_create :set_create_user_url

  has_many :event, inverse_of: :user, dependent: :destroy
  has_many :bank, inverse_of: :user, dependent: :destroy
  has_many :joins, inverse_of: :user, dependent: :destroy
  has_many :purchases, inverse_of: :user, dependent: :destroy
  attr_accessor :current_password

  validates :name, presence: true
  validates :user_url, uniqueness: true
  validates :password, presence: true, on: :create

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: %i[facebook line]

  # omniauth for line
  def social_profile(provider)
    social_profiles.select { |sp| sp.provider == provider.to_s }.first
  end

  # omniauth for facebook
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.confirmed_at = Time.now
    end
  end

  # update no password
  def update_without_current_password(params, *options)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # user's random url
  def to_param
    user_url
  end

  private

  def set_create_user_url
    self.point = 0
    loop do
      self.user_url = SecureRandom.hex(10)
      break unless User.where(user_url: user_url).exists?
    end
  end
end
