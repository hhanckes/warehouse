class CreateOrderReturns < ActiveRecord::Migration
  def change
    create_table :order_returns do |t|
      t.datetime :return_delivery_day
      t.string :return_delivery_time
      t.integer :address_id
      t.integer :order_return_status_id
      t.text :comments

      t.timestamps
    end
  end
end
