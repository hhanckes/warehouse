# encoding: UTF-8
class MainController < ApplicationController
  before_filter :authenticate_user!, :redirect_unless_is_god, except: [:home, :faqs, :user_main_menu]
  
  def home
    #Order.all.destroy_all
    #Address.all.destroy_all
  end
  
  def faqs
    @faq_sections = FaqSection.all
  end 
  
  #GET
  def user_main_menu
    add_breadcrumb "Menú Principal", user_main_menu_path
  end
  
  #ADMIN STUFF
  def admin
  end
  
  def payments
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrar Pagos", main_payments_path
    
    @funds_received = PaymentStatus.find_by_name('Transfer funds received')
    @payments = Payment.all.order('created_at DESC')
  end
  
  def change_price
    osi = OrderStorageItem.find params[:id]
    osi.update_attribute :price, params[:price]
    
    redirect_to main_order_details_path(osi.order), notice: 'Precio actualizado correctamente'
  end
  
  def update_payment_status
    status = PaymentStatus.find params[:status_id]
    payment = Payment.find params[:payment_id]
    payment.payment_status = status
    payment.save
    redirect_to main_payments_path, notice: 'Pago actualizado correctamente'
  end
  
  #GET
  def orders
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrar Ordenes", main_orders_path
    
    step1 = OrderStatus.find_by_name('Step 1')
    step2 = OrderStatus.find_by_name('Step 2')
    @orders = Order.where('order_status_id <> ? and order_status_id <> ?', step1.id, step2.id).order('created_at DESC')

    
    @in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
    @returned = OrderStorageItemStatus.find_by_name('Returned')
    
    @waiting_approval = OrderStatus.find_by_name('Transfer waiting approval')
    @funds_received = OrderStatus.find_by_name('Transfer funds received')
    @delivered = OrderStatus.find_by_name('Delivered')
    @collected = OrderStatus.find_by_name('Collected')
    
    render :template => "orders/index"
  end
  
  def order_details
    add_breadcrumb "Administrador", admin_path
    add_breadcrumb "Administrar Ordenes", main_orders_path
    add_breadcrumb "Detalle Orden", main_order_details_path
    
    step1 = OrderStatus.find_by_name('Step 1')
    step2 = OrderStatus.find_by_name('Step 2')
    
    @in_warehouse = OrderStorageItemStatus.find_by_name('In warehouse')
    @return_in_progress = OrderStorageItemStatus.find_by_name('Return in progress')
    @returned = OrderStorageItemStatus.find_by_name('Returned')
    
    @waiting_approval = OrderStatus.find_by_name('Transfer waiting approval')
    @funds_received = OrderStatus.find_by_name('Transfer funds received')
    @delivered = OrderStatus.find_by_name('Delivered')
    @collected = OrderStatus.find_by_name('Collected')
    
    @order = Order.find(params[:id])
    
    render :template => "orders/show"
  end
  
  #DELETE
  def destroy_order_storage_item
    @order_storage_item = OrderStorageItem.find(params[:id])
    order = @order_storage_item.order
    notice = @order_storage_item.storage_item.name+' id # '+@order_storage_item.id.to_s+' eliminado de la orden '+@order_storage_item.order.id.to_s
    @order_storage_item.destroy
    respond_to do |format|
      format.html { redirect_to main_order_details_path(order), notice: notice }
      format.json { head :no_content }
    end    
  end
  
  #POST
  def update_order_storage_item
    @order_storage_item = OrderStorageItem.find(params[:id])
    respond_to do |format|
      if @order_storage_item.update(order_storage_item_params)
        format.html { redirect_to main_order_details_path(@order_storage_item.order), notice: 'Storage Item actualizado correctamente.' }
      else
        format.html { redirect_to main_order_details_path(@order_storage_item.order), alert: 'ERROR Storage Item NO actualizado correctamente.' }
      end
    end
  end
  
  private
  
  def order_storage_item_params
    params.require(:order_storage_item).permit(:photo, stored_items_attributes: [:id, :name, :description, :quantity, :assigned_value, :_destroy])
  end
  
end
