class AddPasswordDigestToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :password_digest, :string
  end
end
