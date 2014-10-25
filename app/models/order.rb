class Order < ActiveRecord::Base
  after_save :generate_first_payment, :notify
  
  belongs_to :order_status
  belongs_to :address
  belongs_to :user
  has_many :order_storage_items, dependent: :destroy
  has_many :storage_items, through: :order_storage_items
  
  
  private
  
    def generate_first_payment
      if self.order_status.name == 'Transfer funds received'
        status = PaymentStatus.find_by_name('Transfer funds received')
        type = PaymentType.find_by_name('Monthly payment')
        payment = Payment.create(amount: self.order_storage_items.sum(:price), payment_status_id: status.id, payment_type_id: type.id)
      
        month = DateTime.now.strftime('%m')
        year = DateTime.now.strftime('%Y')
        payment.payment_months << (PaymentMonth.find_by_month_and_year(month, year) || PaymentMonth.create(month, year))

        self.order_storage_items.each do |osi|
          payment.order_storage_items << osi
        end
        payment.save
        payment.notify
      end
    end
    
    def notify
      boxes_in_order = self.storage_items.include?(StorageItem.find_by_name('Regular Boxes'))
      unless self.order_status.blank?
        Notification.new_order(self).deliver if order_status.name == 'Transfer waiting approval'
        Notification.order_delivered(self).deliver if order_status.name == 'Delivered' and boxes_in_order
        Notification.order_collected(self).deliver if order_status.name == 'Collected'
      end
    end

end
