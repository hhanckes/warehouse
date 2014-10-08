class OrderStorageItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :storage_item
  
end
