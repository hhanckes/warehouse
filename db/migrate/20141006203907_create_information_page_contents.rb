class CreateInformationPageContents < ActiveRecord::Migration
  def change
    create_table :information_page_contents do |t|
      t.integer :information_page_id
      t.string :title
      t.string :subtitle
      t.text :content

      t.timestamps
    end
  end
end
