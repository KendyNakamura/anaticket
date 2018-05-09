# == Schema Information
#
# Table name: joins
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  event_id   :integer
#

class Join < ApplicationRecord
  belongs_to :user, inverse_of: :joins
  belongs_to :event, inverse_of: :joins
end
