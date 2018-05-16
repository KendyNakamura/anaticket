class Purchase < ApplicationRecord
  belongs_to :event, inverse_of: :purchases
  belongs_to :user, inverse_of: :purchases
  belongs_to :item, inverse_of: :purchases
end
