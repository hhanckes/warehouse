class AddPhotoToTestimony < ActiveRecord::Migration
  def change
      add_attachment :testimonies, :photo
  end
end
