class AddSlugToInformationPage < ActiveRecord::Migration
  def change
    add_column :information_pages, :slug, :string
    add_index :information_pages, :slug, unique: true
  end
end
