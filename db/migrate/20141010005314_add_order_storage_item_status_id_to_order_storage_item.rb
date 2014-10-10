class AddOrderStorageItemStatusIdToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :order_storage_item_status_id, :integer
  end
end
