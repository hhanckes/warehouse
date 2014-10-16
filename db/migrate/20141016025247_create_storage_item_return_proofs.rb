class CreateStorageItemReturnProofs < ActiveRecord::Migration
  def change
    create_table :storage_item_return_proofs do |t|
      t.text :comments

      t.timestamps
    end
  end
end
