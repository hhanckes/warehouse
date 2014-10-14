class AddPublicNameToStorageItem < ActiveRecord::Migration
  def change
    add_column :storage_items, :public_name, :string
  end
end
