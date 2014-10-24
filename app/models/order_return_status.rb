class OrderReturnStatus < ActiveRecord::Base
  has_many :order_returns
  has_many :order_storage_items, through: :order_returns
end
