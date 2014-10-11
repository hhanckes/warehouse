class OrderStorageItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :storage_item
  belongs_to :order_storage_item_status
  has_many :stored_items
  has_and_belongs_to_many :payments
  
  has_attached_file :photo, :styles => { :xl => "500x", :l => "400x", :m => "300x", :s => "200x", :xs => "100x" }

	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :photo, :less_than => 7.megabytes
  
  accepts_nested_attributes_for :stored_items, :reject_if => proc { |a| a[:name].blank? or a[:quantity].blank? }, :allow_destroy => true
  
  def next_payment_date
    DateTime.now
  end
  
  def payment_status
    'Por Pagar'
  end
end
