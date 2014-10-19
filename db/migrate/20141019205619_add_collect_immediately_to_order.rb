class AddCollectImmediatelyToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :collect_immediately, :boolean
  end
end
