class OrderReturn < ActiveRecord::Base
  belongs_to :order_return_status
  belongs_to :user
  belongs_to :address
  
  has_many :order_storage_items
  
  def return_price
    self.order_storage_items.sum(:return_price)
  end
end
