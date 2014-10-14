class InformationPageContent < ActiveRecord::Base
  belongs_to :information_page
  
  validates :information_page_id, :title, :content, presence: true
end
