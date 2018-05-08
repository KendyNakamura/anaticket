class AddColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :max_persons, :integer
  end
end
