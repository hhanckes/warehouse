class RenameTables < ActiveRecord::Migration
  def change
    rename_table :payments_order_storage_items, :order_storage_items_payments
  end
end
