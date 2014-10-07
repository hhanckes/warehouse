class CreateFaqSections < ActiveRecord::Migration
  def change
    create_table :faq_sections do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
