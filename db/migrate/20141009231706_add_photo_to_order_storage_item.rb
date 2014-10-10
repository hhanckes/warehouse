class AddPhotoToOrderStorageItem < ActiveRecord::Migration
  def change
      add_attachment :order_storage_items, :photo
  end
end
