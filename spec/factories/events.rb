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
#  start_time      :datetime
#  start_date      :date
#  event_url       :string(255)      not null
#  finish_time     :datetime
#  free            :string(255)
#

FactoryBot.define do
  factory :event do
    title 'komekami'
    content 'komekami@mail'
    password '12345678'
    password_confirmation '12345678'
  end
end
