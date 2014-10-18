class AddAddressIdToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :address_id, :integer
  end
end
