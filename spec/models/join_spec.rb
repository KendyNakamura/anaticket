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

require 'rails_helper'

RSpec.describe Join, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
