class Event < ApplicationRecord
  belongs_to :user, inverse_of: :event, optional: true
  has_many :joins, inverse_of: :event
  validates :title, presence: true
  # only check on
  validates :password, confirmation: true, length: { within: 4..20 }, presence: true, if: :checked_on?

  has_secure_password(validations: false)

  def checked_on?
    check == '1'
  end
end
