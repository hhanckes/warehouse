class CreateOrderStorageItemStatuses < ActiveRecord::Migration
  def change
    create_table :order_storage_item_statuses do |t|
      t.string :name
      t.string :public_name
      t.text :description

      t.timestamps
    end
  end
end
