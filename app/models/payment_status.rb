class PaymentStatus < ActiveRecord::Base
  has_many :payments, dependent: :destroy
end
