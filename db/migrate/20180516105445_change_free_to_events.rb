class ChangeFreeToEvents < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :free, :string
  end
end
