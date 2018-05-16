# == Schema Information
#
# Table name: events
#
#  id              :bigint(8)        not null, primary key
#  title           :string(255)
#  content         :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#  check           :string(255)
#  user_id         :integer
#  max_persons     :integer
#  start_time      :time
#  start_date      :date
#  event_url       :string(255)      not null
#

class Event < ApplicationRecord
  before_create :set_create_event_url

  belongs_to :user, inverse_of: :event, optional: true
  has_many :joins, inverse_of: :event
  has_many :items, inverse_of: :event
  has_many :purchases, inverse_of: :event
  accepts_nested_attributes_for :items

  validates :title, presence: true
  validates :max_persons, presence: true
  validates :event_url, uniqueness: true
  # only check on
  validates :password, confirmation: true, length: { within: 4..20 }, presence: true, if: :checked_on?

  has_secure_password(validations: false)

  def self.create_charge_by_token(token, amount)
    Payjp::Charge.create(
      amount:   amount,
      card:     token,
      currency: 'jpy'
    )
  end

  def checked_on?
    check == '1'
  end

  def to_param
    event_url
  end

  private

  def set_create_event_url
    loop do
      self.event_url = SecureRandom.hex(10)
      break unless Event.where(event_url: event_url).exists?
    end
  end
end
