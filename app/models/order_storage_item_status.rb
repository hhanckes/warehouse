class OrderStorageItemStatus < ActiveRecord::Base
  has_many :order_storage_items
end
