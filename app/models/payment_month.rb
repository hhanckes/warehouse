class PaymentMonth < ActiveRecord::Base
  has_and_belongs_to_many :payments
end
