class StorageItem < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  
  has_many :order_storage_items, dependent: :destroy
  
  has_attached_file :photo, :styles => { :xl => "500x500", :l => "400x400", :m => "300x300", :s => "200x200", :xs => "100x100", :tiny => "50x50" }

	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg', 'application/pdf']
	validates_attachment_size :photo, :less_than => 7.megabytes
  
end
