# == Schema Information
#
# Table name: items
#
#  id         :bigint(8)        not null, primary key
#  name       :string(255)
#  content    :string(255)
#  price      :integer
#  count      :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Item < ApplicationRecord
  has_many :purchases, inverse_of: :item
  belongs_to :event, inverse_of: :items, optional: true
end
