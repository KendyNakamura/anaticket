class RemoveColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    remove_column :events, :start_date, :date
  end
end
