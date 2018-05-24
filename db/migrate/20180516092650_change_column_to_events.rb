class ChangeColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :start_time, 'timestamp with time zone'
    # change_column :events, :start_time, :datetime
  end
end
