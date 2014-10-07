class CreateInformationPages < ActiveRecord::Migration
  def change
    create_table :information_pages do |t|
      t.string :title
      t.string :subtitle

      t.timestamps
    end
  end
end
