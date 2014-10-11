class PaymentStatus < ActiveRecord::Base
  has_many :payments
end
