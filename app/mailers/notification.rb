class Notification < ActionMailer::Base
  default from: "hhanckes@gmail.com"

  def welcome_user(user)
    @user = user
    mail to: user.email, subject: 'Bienvenido a Warehouse'
  end
  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.new_order.subject
  #
  def new_order(order)
    @order = order
    mail to: order.user.email, subject: 'Felicitaciones por tu nueva orden'
  end

  def order_funds_received(order)
    @user = order.user
    @order = order
    mail to: order.user.email, subject: 'order_funds_received'
  end
  
  def order_delivered(order)
    @user = order.user
    @order = order
    mail to: order.user.email, subject: 'order_delivered'
  end
  
  def order_collected(order)
    @user = order.user
    @order = order
    mail to: order.user.email, subject: 'order_collected'
  end
  
  def item_in_warehouse(order_storage_item)
    @user = order_storage_item.order.user
    @order_storage_item = order_storage_item
    mail to: @user.email, subject: 'item_in_warehouse'
  end
  
  def item_return_request(order_storage_item)
    mail to: order_storage_item.order.user.email, subject: 'item_return_request'
  end
  
  def item_returned(storage_item_return_proof)
    email = storage_item_return_proof.order_storage_items.last.order.user.email
    mail to: email, subject: 'items_returned_proof'
  end
  
  def payment_reminder
    mail to: '', subject: 'payment_reminder'
  end
  
  def payment_submitted(payment)
    mail to: payment.users.first.email, subject: 'payment_reminder'
  end
  
  def payment_paid(payment)
    @payment = payment
    @user = payment.users.first
    mail to: @user.email, subject: 'payment_reminder'
  end
end
