class Item < ApplicationRecord
  belongs_to :event, inverse_of: :items, optional: true
end
