class AddSlugToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_url, :string, null:false
  end
end
