class Order < ActiveRecord::Base
  belongs_to :order_status
  belongs_to :address
  belongs_to :user
  has_many :order_storage_items
  has_many :storage_items, through: :order_storage_items
end
