class ChangeColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :start_time, :datetime
    add_column :events, :start_time, :datetime
  end
end
