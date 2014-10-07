class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :receiver
      t.string :name
      t.string :post_code
      t.integer :area_id
      t.integer :user_id

      t.timestamps
    end
  end
end
