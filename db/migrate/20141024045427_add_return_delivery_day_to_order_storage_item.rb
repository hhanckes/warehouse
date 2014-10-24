class AddReturnDeliveryDayToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :return_delivery_day, :string
  end
end
