class InformationPage < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  has_many :information_page_contents
  
  accepts_nested_attributes_for :information_page_contents, :reject_if => proc { |a| a[:title].blank? }, :allow_destroy => true
end
