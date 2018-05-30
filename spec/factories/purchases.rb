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
#  charge_id  :string(255)
#

FactoryBot.define do
  factory :purchase do
    user_id 1
    item_id 1
    event_id 1
    process 'MyString'
  end
end
