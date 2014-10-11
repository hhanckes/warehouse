class CreatePaymentMonths < ActiveRecord::Migration
  def change
    create_table :payment_months do |t|
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
