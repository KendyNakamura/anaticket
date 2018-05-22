class AddColumnsToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :start_date, :date
    add_column :events, :start_time, :time
  end
end
