class AddQuantityToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :quantity, :integer
  end
end
