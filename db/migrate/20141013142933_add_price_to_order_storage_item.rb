class AddPriceToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :price, :decimal
  end
end
