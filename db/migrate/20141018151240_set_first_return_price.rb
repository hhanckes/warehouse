class SetFirstReturnPrice < ActiveRecord::Migration
  def change
    OrderStorageItem.all.each do |aux|
      aux.update_attribute :return_price, 5000
    end
    StorageItem.all.each do |aux|
      aux.update_attribute :return_price, 5000
    end
  end
end
