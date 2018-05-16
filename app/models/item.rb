class Item < ApplicationRecord
  has_many :purchases, inverse_of: :item
  belongs_to :event, inverse_of: :items, optional: true
end
