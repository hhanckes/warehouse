class AddPhotosToBlog < ActiveRecord::Migration
  def change
    add_column :blog_posts, :slug, :string
    add_index :blog_posts, :slug, unique: true
    
    add_attachment :blog_post_contents, :photo
    add_attachment :blog_posts, :photo
  end
end
