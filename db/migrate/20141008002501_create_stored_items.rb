class CreateStoredItems < ActiveRecord::Migration
  def change
    create_table :stored_items do |t|
      t.integer :order_storage_item_id
      t.string :name
      t.text :description
      t.decimal :assigned_value

      t.timestamps
    end
  end
end
