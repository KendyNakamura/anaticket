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
#

class Event < ApplicationRecord
  belongs_to :user, inverse_of: :event, optional: true
  has_many :joins, inverse_of: :event
  validates :title, presence: true
  validates :max_persons, presence: true
  # only check on
  validates :password, confirmation: true, length: { within: 4..20 }, presence: true, if: :checked_on?

  has_secure_password(validations: false)

  def checked_on?
    check == '1'
  end
end
