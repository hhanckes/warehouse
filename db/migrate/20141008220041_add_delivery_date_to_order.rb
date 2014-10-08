class AddDeliveryDateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_date, :datetime
    add_column :orders, :delivery_time, :string
    add_column :orders, :collection_date, :datetime
    add_column :orders, :collection_time, :string
    add_column :orders, :company_name, :string
    add_column :orders, :company_rut, :string
    add_column :orders, :concierge, :boolean
    add_column :orders, :neighbour, :boolean
  end
end
