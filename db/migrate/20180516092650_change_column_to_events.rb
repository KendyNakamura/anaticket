class ChangeColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :start_time :timestamptz
    # change_column :events, :start_time, :datetime
  end
end
