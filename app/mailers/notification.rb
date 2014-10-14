class Notification < ActionMailer::Base
  default from: "hhanckes@gmail.com", bcc: 'dnocioni1@gmail.com'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.new_order.subject
  #
  def new_order(order)
    @greeting = "Hi"
    mail to: order.user.email, subject: 'Felicitaciones por tu nueva orden'
  end

  def order_funds_received(order)
    mail to: order.user.email, subject: 'order_funds_received'
  end
  
  def order_delivered(order)
    mail to: order.user.email, subject: 'order_delivered'
  end
  
  def order_collected(order)
    mail to: order.user.email, subject: 'order_collected'
  end
  
  def item_in_warehouse(order_storage_item)
    mail to: order_storage_item.order.user.email, subject: 'item_in_warehouse'
  end
  
  def item_return_request(order_storage_item)
    mail to: order_storage_item.order.user.email, subject: 'item_return_request'
  end
  
  def item_returned(order_storage_item)
    mail to: order_storage_item.order.user.email, subject: 'item_returned'
  end
  
  def payment_reminder
    mail to: '', subject: 'payment_reminder'
  end
  
  def payment_submitted(payment)
    mail to: '', subject: 'payment_reminder'
  end
  
  def payment_paid(payment)
    mail to: '', subject: 'payment_reminder'
  end
end