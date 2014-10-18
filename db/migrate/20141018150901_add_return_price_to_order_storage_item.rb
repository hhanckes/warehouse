class AddReturnPriceToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :return_price, :decimal
  end
end
