class User < ActiveRecord::Base
  has_many :orders, dependent: :destroy
  has_many :order_storage_items, through: :orders
  has_many :storage_items, through: :order_storage_items
  has_many :stored_items, through: :order_storage_items
  has_many :addresses, dependent: :destroy
  has_many :areas, through: :addresses
  has_many :countries, through: :areas
  has_many :payments, through: :order_storage_items
  has_many :payment_months, through: :payments
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def is_god?
    self.role_id == 1
  end
  
  def default_address
    self.addresses.where(default: true).first
  end
  
  def in_warehouse_order_storage_items  
    in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
    self.order_storage_items.where(order_storage_item_status_id: in_warehouse.id)
  end
  
  def next_payment_date
    #TODO calcular bien la próxima fecha de pago
    last_paid_month = self.payment_months.last
    
    unless last_paid_month.blank?
      DateTime.new(last_paid_month.year,last_paid_month.month,1) + 1.month + 10.days
    else
      DateTime.now
    end
  end

end
