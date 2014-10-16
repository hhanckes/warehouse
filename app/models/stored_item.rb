class StoredItem < ActiveRecord::Base
  belongs_to :order_storage_item
  has_one :order, through: :order_storage_item
end
