class Event < ApplicationRecord
  belongs_to :user, inverse_of: :events, optional: true
  validates :title, presence: true
  # only check on
  validates :password, confirmation: true, length: { within: 4..20 }, presence: true, if: :checked_on?

  has_secure_password(validations: false)

  def checked_on?
    check == '1'
  end
end
