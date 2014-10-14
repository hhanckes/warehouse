class Faq < ActiveRecord::Base
   belongs_to :faq_section
    
  validates :question, :answer, presence: true
end
