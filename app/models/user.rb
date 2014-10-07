class User < ActiveRecord::Base
  has_many :addresses
  has_many :areas, through: :addresses
  has_many :countries, through: :areas
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  def is_god?
    true
  end
  
end
