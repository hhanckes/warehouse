class FaqSection < ActiveRecord::Base
  has_many :faqs
  validates :name, presence: true
end
