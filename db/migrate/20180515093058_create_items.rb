class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name
      t.string :content
      t.integer :price
      t.integer :count
      t.integer :event_id

      t.timestamps
    end
  end
end
