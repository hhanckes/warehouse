class StorageItemReturnProof < ActiveRecord::Base
  before_save :notify
  
  has_and_belongs_to_many :order_storage_items
  
  has_attached_file :photo, :styles => { :xl => "500x", :l => "400x", :m => "300x", :s => "200x", :xs => "100x" }

	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :photo, :less_than => 7.megabytes
  
  private
  
    def notify
      Notification.item_returned(self).deliver
    end
  
end
