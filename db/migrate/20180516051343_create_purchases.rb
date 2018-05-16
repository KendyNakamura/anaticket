class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.integer :user_id
      t.integer :item_id
      t.integer :event_id
      t.string :process

      t.timestamps
    end
  end
end
