class AddReturnPriceToStorageItem < ActiveRecord::Migration
  def change
    add_column :storage_items, :return_price, :decimal
  end
end
