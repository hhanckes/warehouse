class BlogPost < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  belongs_to :user
  has_many :blog_post_contents
  
  accepts_nested_attributes_for :blog_post_contents, :reject_if => proc { |a| a[:photo].blank? and a[:content].blank? }, :allow_destroy => true
    
  has_attached_file :photo, :styles => { :xl => "500x500", :l => "400x400", :m => "300x300", :s => "200x200", :xs => "100x100", :tiny => "50x50" }

	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png', 'image/gif', 'image/bmp', 'image/x-png', 'image/pjpeg']
	validates_attachment_size :photo, :less_than => 7.megabytes
  
  validates :photo, :title, :subtitle, presence: true
end