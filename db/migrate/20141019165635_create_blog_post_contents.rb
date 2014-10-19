class CreateBlogPostContents < ActiveRecord::Migration
  def change
    create_table :blog_post_contents do |t|
      t.text :content

      t.timestamps
    end
  end
end
