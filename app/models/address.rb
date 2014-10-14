class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :area
  
  validates :area_id, :name, :user_id, presence: true
end
