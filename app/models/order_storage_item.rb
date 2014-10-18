class OrderStorageItem < ActiveRecord::Base
  before_save :notify
  before_save :update_in_warehouse_date
  
  belongs_to :order
  belongs_to :storage_item
  belongs_to :order_storage_item_status
  belongs_to :address #Return Address
  has_many :stored_items, dependent: :destroy
  has_one :user, through: :order
  has_and_belongs_to_many :payments
  has_and_belongs_to_many :storage_item_return_proofs
  
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

  private
  
    def notify
      unless self.order_storage_item_status.blank?
        Notification.item_in_warehouse(self).deliver if self.order_storage_item_status.name == 'In warehouse'
        Notification.item_return_request(self).deliver if self.order_storage_item_status.name == 'Return in progress'
      end
    end
    
    def update_in_warehouse_date
      self.in_warehouse_date = DateTime.now if !self.order_storage_item_status.blank? and self.order_storage_item_status.name == 'In warehouse'
    end
  
end
