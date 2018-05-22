class AddColumnToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :finish_time, :datetime
    add_column :events, :free, :integer
  end

  def up
    change_table :events do |t|
      t.change :start_time, :datetime
    end
  end

  def down
    change_table :events do |t|
      t.change :start_time, :time
    end
  end
end
