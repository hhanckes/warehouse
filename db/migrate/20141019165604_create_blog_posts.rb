class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.integer :user_id
      t.string :title
      t.string :subtitle
      t.string :hashtags

      t.timestamps
    end
  end
end
