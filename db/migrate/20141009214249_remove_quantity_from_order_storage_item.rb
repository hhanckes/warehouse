class RemoveQuantityFromOrderStorageItem < ActiveRecord::Migration
  def change
      remove_column :order_storage_items, :quantity
  end
end
