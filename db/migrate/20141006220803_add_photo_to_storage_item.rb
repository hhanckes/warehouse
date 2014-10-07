class AddPhotoToStorageItem < ActiveRecord::Migration
  def change
    add_column :storage_items, :slug, :string
    add_index :storage_items, :slug, unique: true
    add_attachment :storage_items, :photo
  end
end
