class CreateOrderReturnStatuses < ActiveRecord::Migration
  def change
    create_table :order_return_statuses do |t|
      t.string :name
      t.string :public_name

      t.timestamps
    end
  end
end
