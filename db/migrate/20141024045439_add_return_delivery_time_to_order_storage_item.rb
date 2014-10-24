class AddReturnDeliveryTimeToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :return_delivery_time, :string
  end
end
