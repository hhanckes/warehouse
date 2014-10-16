class TableOrderStorageItemsStorageItemReturnProofs < ActiveRecord::Migration
  def change
    create_table :order_storage_items_storage_item_return_proofs, id: false do |t|
      t.integer :order_storage_item_id
      t.integer :storage_item_return_proof_id
    end
  end
end
