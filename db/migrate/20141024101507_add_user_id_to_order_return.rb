class AddUserIdToOrderReturn < ActiveRecord::Migration
  def change
    add_column :order_returns, :user_id, :integer
  end
end
