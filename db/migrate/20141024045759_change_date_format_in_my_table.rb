class ChangeDateFormatInMyTable < ActiveRecord::Migration
  def change
    change_column :order_storage_items, :return_delivery_day, :datetime
  end
end
