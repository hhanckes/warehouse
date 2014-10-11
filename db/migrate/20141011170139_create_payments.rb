class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.decimal :amount
      t.integer :payment_status_id

      t.timestamps
    end
  end
end
