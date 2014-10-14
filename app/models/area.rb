class Area < ActiveRecord::Base
  has_many :addresses
  belongs_to :country
  
  validates :country_id, :name, presence: true
end
