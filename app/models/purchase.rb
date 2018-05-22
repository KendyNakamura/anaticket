# == Schema Information
#
# Table name: purchases
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer
#  item_id    :integer
#  event_id   :integer
#  process    :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Purchase < ApplicationRecord
  belongs_to :event, inverse_of: :purchases
  belongs_to :user, inverse_of: :purchases
  belongs_to :item, inverse_of: :purchases
end
