class AddDetailsToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :details, :text
  end
end
