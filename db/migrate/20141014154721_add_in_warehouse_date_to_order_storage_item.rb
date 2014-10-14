class AddInWarehouseDateToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :in_warehouse_date, :datetime
  end
end
