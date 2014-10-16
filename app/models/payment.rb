class Payment < ActiveRecord::Base  
  has_and_belongs_to_many :order_storage_items
  has_and_belongs_to_many :payment_months
  belongs_to :payment_status
  belongs_to :payment_type
  has_many :users, through: :order_storage_items

  def user
    self.users.first
  end
  
  def notify
    unless self.payment_status.blank?
      Notification.payment_submitted(self).deliver if self.payment_status.name == 'Transfer waiting approval'
      Notification.payment_paid(self).deliver if self.payment_status.name == 'Transfer funds received'
    end
  end

end
