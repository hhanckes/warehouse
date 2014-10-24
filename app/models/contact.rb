class Contact < ActiveRecord::Base
  before_save :notify
  
  validates :name, :email, :contact_type, :content, presence: true
  
  private

    def notify
      Notification.contact_created(self).deliver
    end
  
end
