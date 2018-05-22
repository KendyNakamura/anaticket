class AddColumnPointToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :point, :integer
  end
end
