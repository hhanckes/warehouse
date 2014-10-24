class RemoveNotUsedColumns < ActiveRecord::Migration
  def change
    remove_column :order_storage_items, :return_delivery_day
    remove_column :order_storage_items, :return_delivery_time
    remove_column :order_storage_items, :address_id
  end
end
