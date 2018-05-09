class Join < ApplicationRecord
  belongs_to :user, inverse_of: :joins
  belongs_to :event, inverse_of: :joins
end
