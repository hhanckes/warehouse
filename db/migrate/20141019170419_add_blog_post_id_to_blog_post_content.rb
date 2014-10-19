class AddBlogPostIdToBlogPostContent < ActiveRecord::Migration
  def change
    add_column :blog_post_contents, :blog_post_id, :integer
  end
end
