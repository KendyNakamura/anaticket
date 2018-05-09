class AddEventUrlToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_url, :string, null:false
  end
end
