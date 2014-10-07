class AddItemPhotoToTestimony < ActiveRecord::Migration
  def change
    add_attachment :testimonies, :item_photo
  end
end
