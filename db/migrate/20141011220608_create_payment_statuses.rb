class CreatePaymentStatuses < ActiveRecord::Migration
  def change
    create_table :payment_statuses do |t|
      t.string :name
      t.string :public_name

      t.timestamps
    end
  end
end
