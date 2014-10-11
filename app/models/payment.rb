class Payment < ActiveRecord::Base
  has_and_belongs_to_many :order_storage_items
  has_and_belongs_to_many :payment_months
  belongs_to :payment_status
end
