class AddQuantityToStoredItem < ActiveRecord::Migration
  def change
    add_column :stored_items, :quantity, :integer
  end
end
