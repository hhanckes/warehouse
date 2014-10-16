class AddPhotoToProof < ActiveRecord::Migration
  def change
      add_attachment :storage_item_return_proofs, :photo
  end
end
