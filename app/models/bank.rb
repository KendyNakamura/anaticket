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

class Bank < ApplicationRecord
  belongs_to :user, inverse_of: :bank

  validates :bank_name, presence: true
  validates :branch_name, presence: true
  validates :deposit_type, presence: true
  validates :bank_num, presence: true
  validates :account_holder, presence: true

  def bank_update(bank)
    NotificationMailer.send_receive_to_bank(bank.user).deliver
    bank.user.update(point: 0)
  end

  def bank_params
    params[
    :bank_name,
    :branch_name,
    :deposit_type,
    :bank_num,
    :account_holder,
    :user_id]
  end
end
