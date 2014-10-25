# encoding: UTF-8
class Notification < ActionMailer::Base
  default from: "hhanckes@gmail.com"

  def contact_created(contact)
    @contact = contact
    mail to: contact.email, subject: 'Hemos recibido tu mensaje'
  end
  
  def welcome_user(user)
    @user = user
    mail to: user.email, subject: 'Bienvenido a Warehouse'
  end
  
  def new_order(order)
    @order = order
    mail to: order.user.email, subject: 'Felicitaciones por tu nueva orden'
  end
  
  def order_delivered(order)
    @user = order.user
    @order = order
    mail to: order.user.email, subject: 'Hemos entregado tu pedido'
  end
  
  def order_collected(order)
    @user = order.user
    @order = order
    mail to: order.user.email, subject: 'Hemos recogido tu pedido'
  end
  
  def item_in_warehouse(order_storage_item)
    @user = order_storage_item.order.user
    @order_storage_item = order_storage_item
    mail to: @user.email, subject: 'Han llegado tus cosas guardadas con el identificador '+@order_storage_item.id.to_s+' a la bodega'
  end
  
  def item_left_warehouse(order_storage_item)
    @user = order_storage_item.order.user
    @order_storage_item = order_storage_item
    mail to: @user.email, subject: 'Tu cosas con el identificador #'+@order_storage_item.id.to_s+' han salido de nuestra bodega para ser devueltas'
  end
  
  def item_return_request(order_storage_item)
    @user = order_storage_item.order.user
    @order_storage_item = order_storage_item
    mail to: @user.email, subject: 'Recibimos los fondos para devolver tus cosas guardadas con el identificador #'+@order_storage_item.id.to_s
  end
  
  def item_returned(storage_item_return_proof)
    @storage_item_return_proof = storage_item_return_proof
    @user = storage_item_return_proof.order_storage_items.last.order.user
    mail to: @user.email, subject: 'Hemos finalizado el proceso de devolución que solicitaste'
  end
  
  def payment_reminder
    mail to: '', subject: 'payment_reminder'
  end
  
  def payment_submitted(payment)
    @payment = payment
    @user = payment.users.first
    mail to: @user.email, subject: 'El pago que realizaste está en proceso de validación'
  end
  
  def payment_paid(payment)
    @regular_boxes = StorageItem.find_by_name('Regular Boxes')
    @payment = payment
    @user = payment.users.first
    mail to: @user.email, subject: '¡Fondos recibidos exitosamente!'
  end
end
