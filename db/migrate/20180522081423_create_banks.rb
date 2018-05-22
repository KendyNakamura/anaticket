class CreateBanks < ActiveRecord::Migration[5.2]
  def change
    create_table :banks do |t|
      t.string :bank_name
      t.string :branch_name
      t.string :deposit_type
      t.integer :bank_num
      t.string :account_holder
      t.integer :user_id

      t.timestamps
    end
  end
end
