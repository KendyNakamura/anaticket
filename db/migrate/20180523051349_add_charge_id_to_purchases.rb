class AddChargeIdToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :charge_id, :string
  end
end
