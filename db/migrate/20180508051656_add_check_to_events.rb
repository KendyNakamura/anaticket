class AddCheckToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :check, :string
  end
end
