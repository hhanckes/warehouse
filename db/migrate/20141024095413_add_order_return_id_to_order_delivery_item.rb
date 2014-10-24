class AddOrderReturnIdToOrderDeliveryItem < ActiveRecord::Migration
  def change
    add_column :order_storage_items, :order_return_id, :integer
  end
end
