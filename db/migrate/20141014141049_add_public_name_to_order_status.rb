class AddPublicNameToOrderStatus < ActiveRecord::Migration
  def change
    add_column :order_statuses, :public_name, :string
  end
end
