class CreateOrderStorageItems < ActiveRecord::Migration
  def change
    create_table :order_storage_items do |t|
      t.integer :order_id
      t.integer :storage_item_id

      t.timestamps
    end
  end
end
