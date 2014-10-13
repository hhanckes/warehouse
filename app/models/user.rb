class User < ActiveRecord::Base
  has_many :orders
  has_many :order_storage_items, through: :orders
  has_many :storage_items, through: :order_storage_items
  has_many :stored_items, through: :order_storage_items
  has_many :addresses
  has_many :areas, through: :addresses
  has_many :countries, through: :areas
  has_many :payments, through: :order_storage_items
  
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
  
  def active_order_storage_items
    #TODO solo devolver los que están activos
    self.order_storage_items
  end
  
  def next_payment_date
    #TODO calcular bien la próxima fecha de pago
    DateTime.now + 1.month
  end

  def next_payment_order_storage_items
    #TODO calcular bien los items a pagar en la próxima fecha
    self.active_order_storage_items
  end

end
