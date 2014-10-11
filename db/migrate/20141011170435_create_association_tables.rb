class CreateAssociationTables < ActiveRecord::Migration
  def change
    create_table :payments_payment_months, id: false do |t|
      t.integer :payment_id
      t.integer :payment_month_id
    end

    create_table :payments_order_storage_items, id: false do |t|
      t.integer :payment_id
      t.integer :order_storage_item_id
    end
  end
end
