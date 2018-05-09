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

FactoryBot.define do
  factory :join do
    event_id 1
    user_id 1
  end
end
