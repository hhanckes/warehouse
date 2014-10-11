class UpdateTableNamePaymentMonthsPayments < ActiveRecord::Migration
  def change
    rename_table :payments_payment_months, :payment_months_payments
  end
end
