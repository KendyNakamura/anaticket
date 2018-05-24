class AddSlugToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_url, :string
  end
end
