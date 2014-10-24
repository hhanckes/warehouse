class AddNameToOrderStorageItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :name, :string
  end
end
