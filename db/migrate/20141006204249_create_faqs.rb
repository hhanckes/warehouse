class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :faq_section_id
      t.string :question
      t.text :answer

      t.timestamps
    end
  end
end
