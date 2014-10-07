class CreateStorageItems < ActiveRecord::Migration
  def change
    create_table :storage_items do |t|
      t.string :name
      t.text :description
      t.decimal :price
      t.decimal :width
      t.decimal :height
      t.decimal :depth
      t.string :dimensions_measure
      t.decimal :capacity
      t.string :capacity_measure

      t.timestamps
    end
  end
end
