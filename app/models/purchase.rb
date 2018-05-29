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

  def self.cansel_charge(purchase)
    Payjp::Charge.create(
      amount: (purchase.item.price * 0.3 + 50).ceil,
      customer: purchase.user.card_token,
      currency: 'jpy',
      description: "id:#{purchase.user.id}様　キャンセル料"
    )
  end

  def self.capture_charge(purchase)
    Payjp::Charge.create(
      amount: purchase.item.price,
      customer: purchase.user.card_token,
      currency: 'jpy',
      capture: false,
      expiry_days: 60,
      description: "id:#{purchase.user.id}様 お支払い"
    )
  end

  def purchase_pay(purchases, point)
    purchases.each do |purchase|
      Payjp::Charge.retrieve(purchase.charge_id).capture
      purchase.update(process: '1')
      point += (purchase.item.price / 1.1).ceil
    end
  end

  def self.cansel_time(purchase)
    (purchase.event.start_time - (Time.now + 1.day)).negative?
  end
end
