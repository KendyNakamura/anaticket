# == Schema Information
#
# Table name: banks
#
#  id             :bigint(8)        not null, primary key
#  bank_name      :string(255)
#  branch_name    :string(255)
#  deposit_type   :string(255)
#  bank_num       :integer
#  account_holder :string(255)
#  user_id        :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :bank do
    bank_name 'MyString'
    branch_name 'MyString'
    deposit_type 'MyString'
    bank_num 1
    account_holder 'MyString'
  end
end
