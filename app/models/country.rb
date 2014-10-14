class Country < ActiveRecord::Base
  has_many :areas
  accepts_nested_attributes_for :areas, :reject_if => proc { |a| a[:name].blank? }, :allow_destroy => true
  
  validates :name, presence: true
end
