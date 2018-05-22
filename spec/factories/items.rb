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

FactoryBot.define do
  factory :item do
    name 'MyString'
    content 'MyString'
    price 1
    count 1
    event_id 1
  end
end
