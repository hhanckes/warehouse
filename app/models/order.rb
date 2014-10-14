class Order < ActiveRecord::Base
  before_save :notify
  
  belongs_to :order_status
  belongs_to :address
  belongs_to :user
  has_many :order_storage_items, dependent: :destroy
  has_many :storage_items, through: :order_storage_items
  
  
  private
  
    def notify
      unless self.order_status.blank?
        Notification.new_order(self).deliver if order_status.name == 'Transfer waiting approval'
        Notification.order_funds_received(self).deliver if order_status.name == 'Transfer funds received'
        Notification.order_delivered(self).deliver if order_status.name == 'Delivered'
        Notification.order_collected(self).deliver if order_status.name == 'Collected' 
      end
    end

end
